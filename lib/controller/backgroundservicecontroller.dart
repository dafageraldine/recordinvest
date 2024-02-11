// background
import 'dart:async';
import 'dart:convert';
import 'dart:io';
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

  Timer.periodic(const Duration(hours: 1), (timer) async {
    // await BackgroundServiceController().showNotif(
    //     contents: "Service update every 1 hour at ${DateTime.now()}");

    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
          title: "Record Invest Service",
          content: "Service update every 1 hour at ${DateTime.now()}",
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

  Timer.periodic(const Duration(minutes: 5), (timer) async {
    await BackgroundServiceController().getWldata();

    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
          title: "Record Invest Service",
          content: "service update every 5 minutes at ${DateTime.now()}",
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
    await Notiticationlocal.showNotif(
        title: title, body: contents, n: flocalnp);
  }

  Future saveData(var key, var values) async {
    late Box box;
    try {
      box = await Hive.openBox('RecordInvestBox');
    } catch (e) {}
    box.put(key, values);
  }

  Future getData(var key) async {
    late Box box;
    try {
      box = await Hive.openBox('RecordInvestBox');
    } catch (e) {}
    return await box.get(key);
  }

  Future getBoxOnly() async {
    late Box box;
    try {
      box = await Hive.openBox('RecordInvestBox');
    } catch (e) {}
    return box;
  }

  Future getWldata() async {
    initializebackground();
    Box boxWl = await getBoxOnly();
    var keyWl = boxWl.keys
        .where((k) => k.toString().toLowerCase().contains("|wl"))
        .toList();
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

        if (dateMorning.isAfter(dateLast)) {
          // Calculate time difference
          Duration timeDifference = dateMorning.difference(dateLast);
          if (timeDifference.inHours >= 8) {
            await updateStockData(
                decodedata['url'], decodedata['name'], decodedata);
          }
        } else if (!dateAfternoon.isAfter(dateLast)) {
          // Calculate time difference
          Duration timeDifference = dateMorning.difference(dateLast);
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
    late Box box;
    try {
      box = await Hive.openBox('RecordInvestBox');
    } catch (e) {}
    await box.close();
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
        playSound: true, importance: Importance.max, priority: Priority.high);
    var not = NotificationDetails(android: chn);
    await n.show(0, title, body, not);
  }
}
