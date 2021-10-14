import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lifehq/constants/strings.dart';
import 'dart:async';
import 'package:timezone/timezone.dart' as tz;

class NotificationsService {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  Future<void> serviceSetup() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  dailyNotif(int _id, String title, String desc, int hour, int min) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        Constants.CHANNEL_ID, Constants.CHANNEL_NAME);
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    final datetime = DateTime.now();
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      _id,
      title,
      desc,
      tz.TZDateTime.from(
          DateTime(
            datetime.year,
            datetime.month,
            datetime.day,
            hour,
            min,
          ),
          tz.local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: _id.toString(),
      androidAllowWhileIdle: true,
    );
  }

  deleteNotif(int _id) async {
    await _flutterLocalNotificationsPlugin.cancel(_id);
  }

  deleteAllNotif() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  launchDetails() async {
    return await _flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();
  }

  Future<List<PendingNotificationRequest>> getPendingNotif() async {
    return await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  printPendingNotif() async {
    (await _flutterLocalNotificationsPlugin.pendingNotificationRequests())
        .forEach((element) {
      print(element.id);
    });
  }
}
