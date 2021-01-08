import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tinggal_makan_app/core/navigation/navigation.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';

final selectNotificationSubsject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingIos = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);

    var initializationSettings = InitializationSettings(
        initializationSettingAndroid, initializationSettingIos);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        print('notification pyload = ' + payload);
      }
      selectNotificationSubsject.add(payload);
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Restaurant restaurant) async {
    var _channelId = '1';
    var _channelName = 'channel_01';
    var _channelDescription = 'JustEat Channel';

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iosPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iosPlatformChannelSpecifics);

    var titleNotification = "<b>RecomendationRestauran Today</b>";
    var titleRestaurant =
        restaurant.name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleRestaurant, platformChannelSpecifics,
        payload: restaurant.id);
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubsject.stream.listen((String payload)  async {
      var restaurantId = payload;
      Navigation.intentWithData(route, restaurantId);
    });
  }
}
