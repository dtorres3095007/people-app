import 'package:flutter/material.dart';
import 'package:people/database/database_helper.dart';
import 'package:people/models/person.dart';
import 'package:people/preference/Preference.dart';
import 'package:people/utils/header_util.dart';
import 'package:intl/intl.dart';
import 'package:people/utils/loading_util.dart';
import 'package:people/utils/show_item_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Person> people = [];
  @override
  void initState() {
    super.initState();
    _obtain();
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: _createContainerBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          _showData(context),
          _isLoading ? LoadingUtil() : Container(),
          const HeaderUtil(),
        ],
      ),
    );
  }

  void _obtain() async {
    people = [];
    _isLoading = true;
    setState(() {});
    people = await DatabaseHelper.instance.getPeople();
    _isLoading = false;
    setState(() {});
  }

  Widget _showData(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 50, top: size.height * 0.23),
        itemCount: people.length,
        itemBuilder: (BuildContext context, int index) {
          return ShowItemUtil(
            title: '${people[index].name} ${people[index].lastName}',
            subTitle:
                'Fecha Nacimiento : ${DateFormat("yyyy-MM-dd").format(DateTime.parse(people[index].date))}',
            context: context,
            callback: () {
              Preferences.person = {
                'id': people[index].id,
                'name': people[index].name,
                'lastName': people[index].lastName,
                'date': DateFormat("yyyy-MM-dd")
                    .format(DateTime.parse(people[index].date)),
              };
              Navigator.pushNamed(context, 'detail');
            },
            img: Image.asset('assets/images/person_list.png',
                width: 40, height: 40),
          );
        });
  }

  Widget _createContainerBtn() {
    return FloatingActionButton(
      backgroundColor: _isLoading ? Colors.red[200] : Colors.red[900],
      onPressed: _isLoading
          ? null
          : () {
              Navigator.pushNamed(context, 'add')
                  .then((value) => setState(() => _obtain()));
            },
      child: const Icon(Icons.add),
    );
  }
}
