// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:people/database/database_helper.dart';
import 'package:people/models/address.dart';
import 'package:people/models/person.dart';

// ignore: camel_case_types
class addressProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name = '';
  int person_id = 0;
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
    Address a = Address(name: name, person_id: person_id);
    await DatabaseHelper.instance.insertAddress(a);
    return 'Resp';
  }

  Future<dynamic> delete(int id) async {
    await DatabaseHelper.instance.deleteAddress(id);
    return 'Resp';
  }
}
