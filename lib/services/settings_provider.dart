import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  static final SettingsProvider instance = SettingsProvider._internal();
  factory SettingsProvider() {
    return instance;
  }
  SettingsProvider._internal() {
    _init();
  }

  bool _initilised = false;
  bool get initilised => _initilised;

  bool _zenBool = false;
  bool get zenBool => _zenBool;

  _init() async {
    if (!initilised) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.containsKey('zenBool'))
        _zenBool = prefs.getBool('zenBool')!;
      else {
        await prefs.setBool('zenBool', false);
        _zenBool = false;
      }

      notifyListeners();
    }
  }

  Future<void> setZenBool(bool _zen) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('zenBool', _zen);
    _zenBool = _zen;

    notifyListeners();
  }
}
