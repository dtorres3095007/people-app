import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:path/path.dart';
import 'package:people/database/database_helper.dart';
import 'package:people/models/person.dart';
import 'package:people/preference/Preference.dart';
import 'package:intl/intl.dart';
import 'package:people/providers/addressProvider.dart';
import 'package:people/providers/personProvider.dart';
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
  int addressId = -1;
  late Person p;
  final appPro = personProvider();
  final AddressPro = addressProvider();
  bool _isLoading = false;

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
    _obtain();
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
            _isLoading ? const LoadingUtil() : Container(),
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

  void _obtain() async {
    address = [];
    _isLoading = true;
    setState(() {});
    address = await DatabaseHelper.instance.getAddress(p.id ?? 0);
    _isLoading = false;
    setState(() {});
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
          _address(context),
        ],
      ),
    );
  }

  Widget _address(context) {
    return Container(
      height: 70.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Direcciones',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 50.0,
            child: ListView(
              children: List<Widget>.generate(
                address.length + 1,
                (int index) {
                  return index == 0
                      ? Container(
                          margin: const EdgeInsets.only(left: 5, top: 5),
                          child: addressId == -1
                              ? _btnUAddAddress(context)
                              : _btnUDeleteAddress(context),
                        )
                      : Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: ChoiceChip(
                            elevation: 1,
                            backgroundColor: Colors.grey[50],
                            avatar: CircleAvatar(
                              child: Text('$index'),
                            ),
                            label: Text(
                              address[index - 1].name,
                            ),
                            selected: addressId == address[index - 1].id,
                            onSelected: (bool selected) {
                              setState(() {
                                if (addressId == address[index - 1].id) {
                                  addressId = -1;
                                } else {
                                  addressId = address[index - 1].id;
                                }
                              });
                            },
                          ),
                        );
                },
              ).toList(),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _btnUAddAddress(context) {
    return FloatingActionButton(
      heroTag: 'btnAddAddress',
      mini: true,
      backgroundColor: Colors.red[900],
      onPressed: () {
        Navigator.pushNamed(context, 'add_address')
            .then((value) => setState(() => _obtain()));
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }

  Widget _btnUDeleteAddress(context) {
    return FloatingActionButton(
        mini: true,
        heroTag: 'btnDeleteAddress',
        child: const Icon(Icons.delete_sharp, color: Colors.white),
        backgroundColor: Colors.orange[900],
        onPressed: () {
          showAlert(
            context,
            '¿ Eliminar Dirección',
            '¿ No podrá recuperar los datos',
            'warning',
            btnCancelText: 'Cancelar',
            btnOkText: 'Eliminar',
            btnCancelOnPress: () => null,
            btnOkOnPress: () {
              AddressPro.delete(addressId);
              addressId = -1;
              showAlert(context, 'Dirección Eliminada',
                  'Los datos fueron enviados y retirados con éxito', 'success',
                  btnCancelText: 'Salir',
                  btnOkText: 'Entiendo',
                  callbackClose: () => _obtain());
            },
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
