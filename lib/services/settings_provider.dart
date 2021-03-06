import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  bool _lockBool = false;
  bool get lockBool => _lockBool;
  String _lockString = "";
  String get lockString => _lockString;
  bool _sendCrashes = false;
  bool get sendCrashes => _sendCrashes;

  final storage = new FlutterSecureStorage();

  _init() async {
    if (!initilised) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.containsKey('zenBool'))
        _zenBool = prefs.getBool('zenBool')!;
      else {
        await prefs.setBool('zenBool', false);
        _zenBool = false;
      }

      if (prefs.containsKey('lockBool'))
        _lockBool = prefs.getBool('lockBool')!;
      else {
        await prefs.setBool('lockBool', false);
        _lockBool = false;
        if (Platform.isAndroid || Platform.isIOS)
          _lockString = await storage.read(key: 'lockBoolKey') ?? "";
      }

      if (prefs.containsKey('sendCrashes'))
        _sendCrashes = prefs.getBool('sendCrashes')!;
      else {
        await prefs.setBool('sendCrashes', false);
        _sendCrashes = false;
      }

      _initilised = true;

      notifyListeners();
    }
  }

  Future<void> setZenBool(bool _zen) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('zenBool', _zen);
    _zenBool = _zen;

    notifyListeners();
  }

  Future<void> setLockBool(
    bool lock,
    // String pass
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('lockBool', lock);
    // await storage.write(key: 'lockBoolKey', value: pass);
    _lockBool = lock;

    notifyListeners();
  }

  Future<void> setSendCrash(bool _crash) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sendCrashes', _crash);
    _sendCrashes = _crash;

    notifyListeners();
  }

  static Future<bool> getSendCrashes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _send = false;
    if (prefs.containsKey('sendCrashes'))
      _send = prefs.getBool('sendCrashes')!;
    else {
      await prefs.setBool('sendCrashes', false);
      _send = false;
    }

    return _send;
  }
}
