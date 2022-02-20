import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/utils/app_route.dart';
import 'package:restaurant_app/utils/navigation_service.dart';


class NotificationService {

  //Singleton pattern
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    //Initialization Settings for Android
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    //Initialization Settings for iOS
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    //InitializationSettings for initializing settings for both platforms (Android & iOS)
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);

    await NotificationService().flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future selectNotification(String payload) async {
    await Navigator.pushNamed(
      NavigationService.navigatorKey.currentContext!,
      AppRoute.NOTIFICATIONS
    );
  }

  listenToMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Got a message whilst in the foreground!');
      // print('Message data: ${message.data}');

      if (message.notification != null) {
        // print('Message also contained a notification: ${message.notification}');

        RemoteNotification notification = message.notification!;
        AndroidNotification android = message.notification!.android!;

        AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'channel ID',
          'channel name',
          playSound: true,
          priority: Priority.high,
          importance: Importance.high,
        );

        NotificationDetails platformChannelSpecifics =
        NotificationDetails(
            android: androidNotificationDetails
        );

        NotificationService().flutterLocalNotificationsPlugin.show(
            1,
            notification.title,
            notification.body,
            platformChannelSpecifics
        );
      }
    });
  }
}