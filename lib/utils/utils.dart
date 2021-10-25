import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lifehq/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utilities {
  static String formatedDate(DateTime dateTime) {
    return DateFormat('dd MMMM, yyyy').format(dateTime);
  }

  static showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static showInfoToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static String beautifulDate(DateTime date) {
    return StringConstants.WEEKDAYS[date.weekday - 1] +
        " , " +
        StringConstants.MONTHS[date.month - 1] +
        " " +
        date.day.toString() +
        " , " +
        date.year.toString() +
        " at " +
        date.hour.toString() +
        ":" +
        date.minute.toString();
  }

  static Future<bool> getPrefBool(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _firstTime = prefs.getBool(StringConstants.FIRSTTIME) ?? true;

    return _firstTime;
  }

  static Future<void> setPrefBool(String name, bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(StringConstants.FIRSTTIME, val);
  }
}
