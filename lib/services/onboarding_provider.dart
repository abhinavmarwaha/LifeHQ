import 'package:flutter/material.dart';
import 'package:lifehq/constants/strings.dart';
import 'package:lifehq/knowledge/models/principle.dart';
import 'package:lifehq/knowledge/services/knowledge_db.dart';
import 'package:lifehq/services/notifications_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider with ChangeNotifier {
  static final OnboardingProvider instance = OnboardingProvider._internal();
  factory OnboardingProvider() {
    return instance;
  }
  OnboardingProvider._internal() {
    _init();
  }

  bool _initilised = false;
  bool get initilised => _initilised;
  bool _firstTime = false;
  bool get firstTime => _firstTime;

  int _year = 0;
  int get year => _year;

  SharedPreferences? _prefs;

  _init() async {
    if (!initilised) {
      _prefs = await SharedPreferences.getInstance();
      _firstTime = _prefs!.getBool(StringConstants.FIRSTTIME) ?? true;
      _year = _prefs!.getInt(StringConstants.BIRTHYEAR) ?? 0;

      if (firstTime) {
        final _notifs = NotificationsService();
        await _notifs.serviceSetup();
        await _notifs.dailyNotif(
            0, "Morning Routine", "Lets prepare for the day ahead", 9, 0);
        await _notifs.dailyNotif(
            1, "Night Routine", "Lets analyse our day", 21, 0);

        _initilised = true;
        notifyListeners();
      } else {
        _initilised = true;
        notifyListeners();
      }
    }
  }

  Future<void> onBoardingCompleted(
      int birthYear, List<String> principles) async {
    _year = birthYear;
    _prefs!.setInt(StringConstants.BIRTHYEAR, birthYear);
    for (String prin in principles) {
      await KnowledgeDB().insertPrinciple(Principle(
        title: prin,
      ));
    }

    _firstTime = false;
    _prefs!.setBool(StringConstants.FIRSTTIME, false);
    notifyListeners();
  }
}
