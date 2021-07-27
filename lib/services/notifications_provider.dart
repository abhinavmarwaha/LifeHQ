import 'package:flutter/material.dart';
import 'package:lifehq/constants/strings.dart';
import 'package:lifehq/services/notifications_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsProvider with ChangeNotifier {
  static final NotificationsProvider instance =
      NotificationsProvider._internal();
  factory NotificationsProvider() {
    return instance;
  }
  NotificationsProvider._internal() {
    _init();
  }

  bool _initilised = false;
  bool get initilised => _initilised;
  bool _firstTime = false;
  bool get firstTime => _firstTime;

  _init() async {
    if (!initilised) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _firstTime = prefs.getBool(Constants.FIRSTTIME) ?? true;
      if (_firstTime) {
        final _notifs = NotificationsService();
        await _notifs.dailyNotif(
            0, "Morning Routine", "Lets prepare for the day ahead", 9, 0);
        await _notifs.dailyNotif(
            1, "Night Routine", "Lets analyse our day", 21, 0);
        prefs.setBool(Constants.FIRSTTIME, false);
        _initilised = true;
        notifyListeners();
      }
    }
  }
}
