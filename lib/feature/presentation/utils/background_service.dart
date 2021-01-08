import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:http/http.dart' as http;
import 'package:tinggal_makan_app/core/notification/notification_helper.dart';
import 'package:tinggal_makan_app/feature/data/rest/api_service_impl.dart';

import '../../../main.dart';

final ReceivePort receivePort = ReceivePort();

class BackgroundService {
  static BackgroundService _service;
  static String _isolateName = 'isolate';
  static SendPort _uiSendPort;

  BackgroundService._createObject();

  factory BackgroundService() {
    if (_service == null) {
      _service = BackgroundService._createObject();
    }

    return _service;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(receivePort.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    print('Alarm fired');
    final NotificationHelper _notificationHelper = NotificationHelper();
    final  _getRestaurantList = await ApisServiceImpl(http.Client()).getRestaurantsList();
    Random random = Random();

    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, _getRestaurantList[random.nextInt(20)]);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Execute get restaurant data from alarm service');
  }
}
