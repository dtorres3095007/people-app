// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Preferences {
  static late SharedPreferences _prefs;
  static String _action = 'add';
  static String _person = '';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get action {
    return _prefs.getString('action') ?? _action;
  }

  static set action(String action) {
    _action = action;
    _prefs.setString('action', _action);
  }

  static Map<String, dynamic> get person {
    String? resp = _prefs.getString('person') ?? '';
    return resp.isNotEmpty ? json.decode(resp) : null;
  }

  static set person(person) {
    _person = json.encode(person);
    _prefs.setString('person', _person);
  }
}
