// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:people/database/database_helper.dart';
import 'package:people/models/person.dart';

// ignore: camel_case_types
class appProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name = '';
  String lastName = '';
  String date = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<dynamic> add() async {
    Person p = Person(name: name, lastName: lastName, date: date);
    await DatabaseHelper.instance.insertPerson(p);
    return 'Resp';
  }
}
