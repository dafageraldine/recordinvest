// background
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:path_provider/path_provider.dart';

import '../models/allmodel.dart';
import '../models/data.dart';

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  //on ready (EXECUTED ONLY ONCE WHEN BACKROUND SERVICE STARTED)
  onReady(service);

  Timer.periodic(const Duration(minutes: 1), (timer) async {
    await BackgroundServiceController().getWldata();
    await BackgroundServiceController().analyzeWl();

    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
          title: "Record Invest Service",
          content: "Service update every 15 minutes at ${DateTime.now()}",
        );
      }
    }

    final deviceInfo = DeviceInfoPlugin();
    String? device;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.model;
    }

    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      device = iosInfo.model;
    }

    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
        "device": device,
      },
    );
  });
}

Future<void> onReady(ServiceInstance service) async {
  await BackgroundServiceController().initializebackground();

  if (service is AndroidServiceInstance) {
    if (await service.isForegroundService()) {
      service.setForegroundNotificationInfo(
        title: "Record Invest Service",
        content: "wake up task at ${DateTime.now()}",
      );
    }
  }

  final deviceInfo = DeviceInfoPlugin();
  String? device;
  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    device = androidInfo.model;
  }

  if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    device = iosInfo.model;
  }

  service.invoke(
    'update',
    {
      "current_date": DateTime.now().toIso8601String(),
      "device": device,
    },
  );
  //
}

class BackgroundServiceController {
  late FlutterLocalNotificationsPlugin flocalnp;

  initializebackground() async {
    try {
      //hive initialization
      Directory directory = await getApplicationDocumentsDirectory();
      Hive.init(directory.path);

      //local notif initialization
      flocalnp = FlutterLocalNotificationsPlugin();
      await Notiticationlocal.initialize(flocalnp);
    } catch (e) {}
  }

  Future showNotif(
      {String title = "record invest", required String contents}) async {
    var rng = Random();
    await Notiticationlocal.showNotif(
        id: rng.nextInt(100), title: title, body: contents, n: flocalnp);
  }

  Future saveData(var key, var values) async {
    try {
      if (!Hive.isBoxOpen('RecordInvestBox')) {
        await Hive.openBox('RecordInvestBox');
      }
      await Hive.box('RecordInvestBox').put(key, values);
    } catch (e) {}
  }

  Future getData(var key) async {
    try {
      if (!Hive.isBoxOpen('RecordInvestBox')) {
        await Hive.openBox('RecordInvestBox');
      }
      return await Hive.box('RecordInvestBox').get(key);
    } catch (e) {
      await Hive.openBox('RecordInvestBox');
      return await Hive.box('RecordInvestBox').get(key);
    }
  }

  Future getBoxOnly() async {
    try {
      if (!Hive.isBoxOpen('RecordInvestBox')) {
        await Hive.openBox('RecordInvestBox');
      }
      return Hive.box('RecordInvestBox');
    } catch (e) {
      return await Hive.openBox('RecordInvestBox');
    }
  }

  Future analyzeStock(var jsons) async {
    try {
      http.Response getdata = await http.get(Uri.parse(
          "${baseurl}analyze?jenis=${jsons['jenis']}&code=${jsons['name']}&money=10000000"));
      Map<String, dynamic> json = jsonDecode(getdata.body);
      AnalyzeDataModel dataModel = AnalyzeDataModel.fromJson(json);
      var jsonNotif = {
        'type': 'stock analyze',
        'tgl': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
        'judul': 'analyze watchlist data',
        'body': "analisa data saham ${jsons['name']} selesai"
      };
      await saveData('analyze-${jsons['name']}|notif', jsonEncode(jsonNotif));
      showNotif(
          contents: "analisa data saham ${jsons['name']} selesai",
          title: "Analyze Watchlist Data");
      int counters = 0;
      bool isError = false;
      for (var data in dataModel.data) {
        if (data.probability > 60 && counters < 5) {
          counters++;
          bool errorCheck = await analyzeDetail(data.maCompared, jsons);
          if (!errorCheck) {
            isError = true;
          }
        }
      }
      if (counters == 0) {
        showNotif(
            contents:
                "analisa detail ma dan data saham ${jsons['name']} selesai",
            title: "Analyze Watchlist Data");
        var jsonNotif = {
          'type': 'stock detail analyze',
          'tgl': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
          'judul': 'detail analyze watchlist data',
          'body': "analisa detail data saham ${jsons['name']} selesai"
        };
        await saveData('detail-${jsons['name']}|notif', jsonEncode(jsonNotif));
      } else if (!isError) {
        var jsonNotif = {
          'type': 'stock detail analyze',
          'tgl': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
          'judul': 'detail analyze watchlist data',
          'body': "analisa detail data saham ${jsons['name']} selesai"
        };
        await saveData('detail-${jsons['name']}|notif', jsonEncode(jsonNotif));
      }
    } catch (e) {
      showNotif(
          contents: "analisa data saham ${jsons['name']} gagal",
          title: "Analyze Watchlist Data");
      var jsonNotif = {
        'type': 'stock analyze',
        'tgl': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
        'judul': 'analyze watchlist data',
        'body': "analisa data saham ${jsons['name']} gagal"
      };
      await saveData('analyze-${jsons['name']}|notif', jsonEncode(jsonNotif));
    }
  }

  Future<bool> analyzeDetail(String ma, var jsons) async {
    try {
      http.Response getdata = await http.get(Uri.parse(
          "${baseurl}detail_analyze?jenis=${jsons['jenis']}&code=${jsons['name']}&maselected=${ma.replaceAll("&", "_")}"));
      Map<String, dynamic> json = jsonDecode(getdata.body);
      ResultAnalyzeDetailModel dataModel =
          ResultAnalyzeDetailModel.fromJson(json);
      DateTime now = DateTime.now();
      var datenow = DateFormat('yyyy-MM-dd').format(now);
      DateTime datenows = DateFormat("yyyy-MM-dd").parse(datenow);
      // Parse the date string
      DateTime date = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'")
          .parse(dataModel.data[dataModel.data.length - 1].date);

      // Format the parsed date into the desired format
      String formattedDate = DateFormat("yyyy-MM-dd").format(date);
      DateTime dateaction = DateFormat("yyyy-MM-dd").parse(formattedDate);
      Duration timeDifference = datenows.difference(dateaction);
      if (timeDifference.inDays <= 7) {
        var jsonNotif = {
          'type': 'stock recommendation analyze',
          'tgl': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
          'judul': 'stock recommendation',
          'body':
              "Sinyal ${dataModel.data[dataModel.data.length - 1].action} untuk ${jsons['name']}, dengan metode $ma pada $formattedDate"
        };
        await saveData(
            'recommendation-${jsons['name']}-$ma|notif', jsonEncode(jsonNotif));
        await showNotif(
            contents:
                "Sinyal ${dataModel.data[dataModel.data.length - 1].action} untuk ${jsons['name']}",
            title: "Stock Recommendation");
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future analyzeWl() async {
    initializebackground();
    Box boxWl = await getBoxOnly();
    var keyWl = boxWl.keys
        .where((k) => k.toString().toLowerCase().contains("|wl"))
        .toList();
    var keyAnalyze = boxWl.keys
        .where((k) => k.toString().toLowerCase().contains("analyze-"))
        .toList();
    if (keyWl.isEmpty) {
      await closeBox();
      return;
    }
    for (var i = 0; i < keyWl.length; i++) {
      var dataWl = await getData(keyWl[i]);
      var decodedata = jsonDecode(dataWl);
      if (decodedata['lastupdate'] != "") {
        // Get current DateTime
        DateTime now = DateTime.now();

        //upate data saham tiap  jam 08:00 dan 16:00
        var date = DateFormat('yyyy-MM-dd').format(now);
        var morning = "$date 08:00:00";
        var afternoon = "$date 16:00:00";
        DateTime dateMorning = DateFormat("yyyy-MM-dd HH:mm:ss").parse(morning);
        DateTime dateAfternoon =
            DateFormat("yyyy-MM-dd HH:mm:ss").parse(afternoon);

        // Example date string
        String dateString1 = decodedata['lastupdate'];

        // Convert string to DateTime object
        DateTime dateLast =
            DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateString1);

        var datenow = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
        DateTime datenows = DateFormat("yyyy-MM-dd HH:mm:ss").parse(datenow);

        bool isFound = false;
        if (dateMorning.isAfter(dateLast)) {
          // Calculate time difference
          Duration timeDifference = dateMorning.difference(dateLast);
          if (timeDifference.inHours < 8) {
            for (var k = 0; k < keyAnalyze.length; k++) {
              if (keyAnalyze[k] == 'analyze-${decodedata['name']}|notif') {
                var dataAnalyze = await getData(keyAnalyze[k]);
                var decodedataAnalyze = jsonDecode(dataAnalyze);
                if (decodedataAnalyze['body']
                    .toString()
                    .toLowerCase()
                    .contains('gagal')) {
                  break;
                } else {
                  DateTime dateNotif = DateFormat("yyyy-MM-dd HH:mm:ss")
                      .parse(decodedataAnalyze['tgl']);
                  if (dateMorning.isAfter(dateNotif)) {
                    // Calculate time difference
                    Duration timeDiff = dateMorning.difference(dateNotif);
                    if (timeDiff.inHours < 8) {
                      isFound = true;
                    }
                  } else if (dateAfternoon.isAfter(dateNotif) &&
                      !dateAfternoon.isAfter(datenows)) {
                    // Calculate time difference
                    Duration timeDiff = dateAfternoon.difference(dateNotif);
                    if (timeDiff.inHours < 8) {
                      isFound = true;
                    }
                  } else {
                    isFound = true;
                  }
                  break;
                }
              }
            }
            if (!isFound) {
              await analyzeStock(decodedata);
            } else {
              var keydetailstock = boxWl.keys
                  .where((k) => k
                      .toString()
                      .toLowerCase()
                      .contains("detail-${decodedata['name']}".toLowerCase()))
                  .toList();
              if (keydetailstock.isEmpty) {
                await analyzeStock(decodedata);
              }
            }
          }
        } else if (dateAfternoon.isAfter(dateLast) &&
            !dateAfternoon.isAfter(datenows)) {
          // Calculate time difference
          Duration timeDifference = dateMorning.difference(dateLast);
          if (timeDifference.inHours < 8) {
            for (var k = 0; k < keyAnalyze.length; k++) {
              if (keyAnalyze[k] == 'analyze-${decodedata['name']}|notif') {
                var dataAnalyze = await getData(keyAnalyze[k]);
                var decodedataAnalyze = jsonDecode(dataAnalyze);
                if (decodedataAnalyze['body']
                    .toString()
                    .toLowerCase()
                    .contains('gagal')) {
                  break;
                } else {
                  DateTime dateNotif = DateFormat("yyyy-MM-dd HH:mm:ss")
                      .parse(decodedataAnalyze['tgl']);
                  if (dateMorning.isAfter(dateNotif)) {
                    // Calculate time difference
                    Duration timeDiff = dateMorning.difference(dateNotif);
                    if (timeDiff.inHours < 8) {
                      isFound = true;
                    }
                  } else if (dateAfternoon.isAfter(dateNotif) &&
                      !dateAfternoon.isAfter(datenows)) {
                    // Calculate time difference
                    Duration timeDiff = dateAfternoon.difference(dateNotif);
                    if (timeDiff.inHours < 8) {
                      isFound = true;
                    }
                  } else {
                    isFound = true;
                  }
                  break;
                }
              }
            }
            if (!isFound) {
              await analyzeStock(decodedata);
            } else {
              var keydetailstock = boxWl.keys
                  .where((k) => k
                      .toString()
                      .toLowerCase()
                      .contains("detail-${decodedata['name']}".toLowerCase()))
                  .toList();
              if (keydetailstock.isEmpty) {
                await analyzeStock(decodedata);
              }
            }
          }
        } else {
          for (var k = 0; k < keyAnalyze.length; k++) {
            if (keyAnalyze[k] == 'analyze-${decodedata['name']}|notif') {
              var dataAnalyze = await getData(keyAnalyze[k]);
              var decodedataAnalyze = jsonDecode(dataAnalyze);
              if (decodedataAnalyze['body']
                  .toString()
                  .toLowerCase()
                  .contains('gagal')) {
                break;
              } else {
                DateTime dateNotif = DateFormat("yyyy-MM-dd HH:mm:ss")
                    .parse(decodedataAnalyze['tgl']);
                if (dateMorning.isAfter(dateNotif)) {
                  // Calculate time difference
                  Duration timeDiff = dateMorning.difference(dateNotif);
                  if (timeDiff.inHours < 8) {
                    isFound = true;
                  }
                } else if (dateAfternoon.isAfter(dateNotif) &&
                    !dateAfternoon.isAfter(datenows)) {
                  // Calculate time difference
                  Duration timeDiff = dateAfternoon.difference(dateNotif);
                  if (timeDiff.inHours < 8) {
                    isFound = true;
                  }
                } else {
                  isFound = true;
                }
                break;
              }
            }
          }
          if (!isFound) {
            await analyzeStock(decodedata);
          } else {
            var keydetailstock = boxWl.keys
                .where((k) => k
                    .toString()
                    .toLowerCase()
                    .contains("detail-${decodedata['name']}".toLowerCase()))
                .toList();
            if (keydetailstock.isEmpty) {
              await analyzeStock(decodedata);
            }
          }
        }
      }
    }
    await closeBox();
  }

  Future getWldata() async {
    initializebackground();
    Box boxWl = await getBoxOnly();
    var keyWl = boxWl.keys
        .where((k) => k.toString().toLowerCase().contains("|wl"))
        .toList();
    if (keyWl.isEmpty) {
      await closeBox();
      return;
    }
    for (var i = 0; i < keyWl.length; i++) {
      var dataWl = await getData(keyWl[i]);
      var decodedata = jsonDecode(dataWl);
      if (decodedata['lastupdate'] == "") {
        await updateStockData(
            decodedata['url'], decodedata['name'], decodedata);
      } else {
        // Get current DateTime
        DateTime now = DateTime.now();

        //upate data saham tiap  jam 08:00 dan 16:00
        var date = DateFormat('yyyy-MM-dd').format(now);
        var morning = "$date 08:00:00";
        var afternoon = "$date 16:00:00";
        DateTime dateMorning = DateFormat("yyyy-MM-dd HH:mm:ss").parse(morning);
        DateTime dateAfternoon =
            DateFormat("yyyy-MM-dd HH:mm:ss").parse(afternoon);

        // Example date string
        String dateString1 = decodedata['lastupdate'];

        // Convert string to DateTime object
        DateTime dateLast =
            DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateString1);

        var datenow = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
        DateTime datenows = DateFormat("yyyy-MM-dd HH:mm:ss").parse(datenow);

        if (dateMorning.isAfter(dateLast)) {
          // Calculate time difference
          Duration timeDifference = dateMorning.difference(dateLast);
          if (timeDifference.inHours >= 8) {
            await updateStockData(
                decodedata['url'], decodedata['name'], decodedata);
          }
        } else if (dateAfternoon.isAfter(dateLast) &&
            !dateAfternoon.isAfter(datenows)) {
          // Calculate time difference
          Duration timeDifference = dateAfternoon.difference(dateLast);
          print(timeDifference.inHours);
          if (timeDifference.inHours >= 8) {
            await updateStockData(
                decodedata['url'], decodedata['name'], decodedata);
          }
        }
      }
    }
    await closeBox();
  }

  Future updateStockData(String url, String filename, var json) async {
    try {
      // example
      // https://dafageraldine.pythonanywhere.com/update_stock?jenis=us&kode=GOOG&saveas=GOOG&start=2018-01-01&end=2023-05-29
      http.Response getdata = await http.get(
          Uri.parse('$url${DateFormat("yyyy-MM-dd").format(DateTime.now())}'));
      var data = jsonDecode(getdata.body);
      if (data['message'] == "success") {
        showNotif(
            contents: "data saham $filename berhasil di update",
            title: "Update Watchlist Data");
        var jsonNotif = {
          'type': 'stock update',
          'tgl': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
          'judul': 'update watchlist data',
          'body': "data saham $filename berhasil di update"
        };
        await saveData('$filename|notif', jsonEncode(jsonNotif));
        var jsonData = {
          'name': json['name'],
          'kode': json['kode'],
          'jenis': json['jenis'],
          'start': json['start'],
          'url': json['url'],
          'lastupdate': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now())
        };
        await saveData('$filename|wl', jsonEncode(jsonData));
      } else {
        showNotif(
            contents: "data saham $filename gagal di update",
            title: "Update Watchlist Data");
        var jsonNotif = {
          'type': 'stock update',
          'tgl': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
          'judul': 'update watchlist data',
          'body': "data saham $filename gagal di update"
        };
        await saveData('$filename|notif', jsonEncode(jsonNotif));
      }
    } catch (e) {
      showNotif(
          contents: "data saham $filename gagal di update",
          title: "Update Watchlist Data");
      var jsonNotif = {
        'type': 'stock update',
        'tgl': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
        'judul': 'update watchlist data',
        'body': "data saham $filename gagal di update"
      };
      await saveData('$filename|notif', jsonEncode(jsonNotif));
    }
  }

  Future closeBox() async {
    try {
      if (Hive.isBoxOpen('RecordInvestBox')) {
        await Hive.box('RecordInvestBox').close();
      }
    } catch (e) {}
  }

  //  initialize
  Future<void> initializeService() async {
    //hive initialization
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    //local notif initialization
    flocalnp = FlutterLocalNotificationsPlugin();
    await Notiticationlocal.initialize(flocalnp);

    //background service initialization
    final service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: null,
        onBackground: null,
      ),
    );

    service.startService();
  }
}

class Notiticationlocal {
  static Future initialize(FlutterLocalNotificationsPlugin n) async {
    var androidInit = const AndroidInitializationSettings('mipmap/ic_launcher');
    var initset = InitializationSettings(android: androidInit);
    await n.initialize(initset);
  }

  static Future showNotif(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin n}) async {
    AndroidNotificationDetails chn = const AndroidNotificationDetails(
        'ch id', 'ch name',
        playSound: true,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority);
    var not = NotificationDetails(android: chn);
    await n.show(id, title, body, not);
  }
}
