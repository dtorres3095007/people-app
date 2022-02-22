// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Preferences {
  static late SharedPreferences _prefs;

  static String _name = '';
  static String _typeUser = '';
  static String _email = '';
  static String _page = 'login';
  static bool _isAuth = false;
  static String _tokenR = '';
  static String _tokenA = '';
  static String _resource = '';
  static String _employe = '';
  static String _customer = '';
  static String _process = '';
  static String _resourceAction = 'add';
  static String _ShowPhotoProcess = '1';
  static String _employesAction = 'add';
  static String _customersAction = 'add';
  static String _processAction = 'add';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isAuth {
    return _prefs.getBool('isAuth') ?? _isAuth;
  }

  static set isAuth(bool isAuth) {
    _isAuth = isAuth;
    _prefs.setBool('isAuth', _isAuth);
  }

  static String get name {
    return _prefs.getString('name') ?? _name;
  }

  static set name(String name) {
    _name = name;
    _prefs.setString('name', _name);
  }

  static String get email {
    return _prefs.getString('email') ?? _email;
  }

  static set email(String email) {
    _email = email;
    _prefs.setString('email', _email);
  }

  static String get typeUser {
    return _prefs.getString('typeUser') ?? _typeUser;
  }

  static set typeUser(String typeUser) {
    _typeUser = typeUser;
    _prefs.setString('typeUser', _typeUser);
  }

  static String get tokenR {
    return _prefs.getString('tokenR') ?? _tokenR;
  }

  static set tokenR(String tokenR) {
    _tokenR = tokenR;
    _prefs.setString('tokenR', _tokenR);
  }

  static String get tokenA {
    return _prefs.getString('tokenA') ?? _tokenA;
  }

  static set tokenA(String tokenA) {
    _tokenA = tokenA;
    _prefs.setString('tokenA', _tokenA);
  }

  static String get page {
    return _prefs.getString('page') ?? _page;
  }

  static set page(String page) {
    _page = page;
    _prefs.setString('page', _page);
  }

  static Map<String, dynamic> get resource {
    String? resp = _prefs.getString('resource') ?? '';
    return resp.isNotEmpty ? json.decode(resp) : null;
  }

  static set resource(resource) {
    _resource = json.encode(resource);
    _prefs.setString('resource', _resource);
  }

  static Map<String, dynamic> get employe {
    String? resp = _prefs.getString('employe') ?? '';
    return resp.isNotEmpty ? json.decode(resp) : null;
  }

  static set employe(employe) {
    _employe = json.encode(employe);
    _prefs.setString('employe', _employe);
  }

  static Map<String, dynamic> get customer {
    String? resp = _prefs.getString('customer') ?? '';
    return resp.isNotEmpty ? json.decode(resp) : null;
  }

  static set customer(customer) {
    _customer = json.encode(customer);
    _prefs.setString('customer', _customer);
  }

  static Map<String, dynamic> get process {
    String? resp = _prefs.getString('process') ?? '';
    return resp.isNotEmpty ? json.decode(resp) : null;
  }

  static set process(process) {
    _process = json.encode(process);
    _prefs.setString('process', _process);
  }

  static String get resourceAction {
    return _prefs.getString('resourceAction') ?? _resourceAction;
  }

  static set resourceAction(String resourceAction) {
    _resourceAction = resourceAction;
    _prefs.setString('resourceAction', resourceAction);
  }

  static String get processAction {
    return _prefs.getString('processAction') ?? _processAction;
  }

  static set processAction(String processAction) {
    _processAction = processAction;
    _prefs.setString('processAction', processAction);
  }

  static String get employesAction {
    return _prefs.getString('employesAction') ?? _employesAction;
  }

  static set employesAction(String employesAction) {
    _employesAction = employesAction;
    _prefs.setString('employesAction', employesAction);
  }

  static String get ShowPhotoProcess {
    return _prefs.getString('ShowPhotoProcess') ?? _ShowPhotoProcess;
  }

  static set ShowPhotoProcess(String ShowPhotoProcess) {
    _ShowPhotoProcess = ShowPhotoProcess;
    _prefs.setString('ShowPhotoProcess', ShowPhotoProcess);
  }

  static String get customersAction {
    return _prefs.getString('customersAction') ?? _customersAction;
  }

  static set customersAction(String customersAction) {
    _customersAction = customersAction;
    _prefs.setString('customersAction', customersAction);
  }
}
