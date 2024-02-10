// background
import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
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
    await BackgroundServiceController()
        .showNotif("Service update every 1 hour at ${DateTime.now()}");

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
    await BackgroundServiceController()
        .showNotif("service update every 5 minutes at ${DateTime.now()}");

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

  Timer.periodic(const Duration(minutes: 3), (timer) async {
    await BackgroundServiceController()
        .showNotif("service update every 3 minutes at ${DateTime.now()}");

    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
          title: "Record Invest Service",
          content: "service update every 3 minutes at ${DateTime.now()}",
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
  await BackgroundServiceController()
      .showNotif("wake up task at ${DateTime.now()}");

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
  // final FlutterLocalNotificationsPlugin flocalnp =
  //       FlutterLocalNotificationsPlugin();

  Future showNotif(var contents) async {
    try {
      flocalnp = FlutterLocalNotificationsPlugin();
      await Notiticationlocal.initialize(flocalnp);
    } catch (e) {}

    // await Notiticationlocal.showNotif(
    //     title: 'Testing notif', body: contents, n: flocalnp);
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
