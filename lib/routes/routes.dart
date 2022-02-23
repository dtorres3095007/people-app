import 'package:flutter/material.dart';
import 'package:people/screens/create__screen.dart';
import 'package:people/screens/create_address__screen.dart';
import 'package:people/screens/detail__screen.dart';
import 'package:people/screens/home_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'home': (BuildContext context) => const HomeScreen(),
    'add': (BuildContext context) => const CreateScreen(),
    'detail': (BuildContext context) => const DetailScreen(),
    'add_address': (BuildContext context) => const CreateAddressScreen(),
  };
}
