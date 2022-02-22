import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:path/path.dart';
import 'package:people/models/person.dart';
import 'package:people/preference/Preference.dart';
import 'package:intl/intl.dart';
import 'package:people/providers/appProvider.dart';
import 'package:people/utils/header_secondary_util.dart';
import 'package:people/utils/loading_util.dart';
import 'package:people/utils/show_item_util.dart';
import 'package:people/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<DetailScreen> {
  List address = [];
  late Person p;
  final appPro = appProvider();

  @override
  void initState() {
    super.initState();
    dynamic check = Preferences.person;
    p = Person(
      id: check['id'],
      name: check['name'],
      lastName: check['lastName'],
      date: check['date'],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: size.width * 0.8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: [
            _btnUpdate(context),
            _btnDelete(context),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            _createBody(context),
            HeaderSecondaryUtil(
              context: context,
              title: 'DETALLE PERSONA',
            ),
            Container(
              margin: EdgeInsets.only(left: size.width * 0.8, top: 80.0),
              child: Image.asset(
                'assets/images/person_list.png',
                height: 80,
                width: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: 100.0, bottom: 20.0, left: 15.0, right: 15.0),
      child: ListView(
        children: [
          ListTile(
            title: const Text(
              'Nombre Completo',
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(
              '${p.name} ${p.lastName}',
              style: const TextStyle(color: Colors.grey),
            ),
            leading: const Icon(Icons.person, color: Colors.blue),
          ),
          ListTile(
            title: const Text(
              'Fecha de Nacimiento',
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(
              p.date,
              style: const TextStyle(color: Colors.grey),
            ),
            leading: const Icon(Icons.date_range, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _showData(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 50, top: size.height * 0.23),
        itemCount: address.length,
        itemBuilder: (BuildContext context, int index) {
          return ShowItemUtil(
            title: '${address[index].name} ${address[index].lastName}',
            subTitle:
                'Fecha Nacimiento : ${DateFormat("yyyy-MM-dd").format(DateTime.parse(address[index].date))}',
            context: context,
            callback: () => null,
            img: Image.asset('assets/images/person_list.png',
                width: 40, height: 40),
          );
        });
  }

  Widget _btnUpdate(context) {
    return FloatingActionButton(
        mini: true,
        heroTag: 'btnUpdate',
        child: const Icon(Icons.edit, color: Colors.white),
        backgroundColor: const Color(0xff296DC8),
        onPressed: () {
          Preferences.action = 'update';
          Navigator.pushNamed(context, 'add');
        });
  }

  Widget _btnDelete(context) {
    return FloatingActionButton(
        mini: true,
        heroTag: 'btnDelete',
        child: const Icon(Icons.delete_sharp, color: Colors.white),
        backgroundColor: Colors.orange[900],
        onPressed: () {
          appPro.delete(p.id ?? 0);
          showAlert(context, 'Persona Eliminada',
              'Los datos fueron enviados y retirados con éxito', 'success',
              btnCancelText: 'Salir',
              btnOkText: 'Entiendo',
              btnCancelOnPress: () => null,
              callbackClose: () => Navigator.pop(context, false));
        });
  }
}
