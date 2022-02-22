import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class HeaderUtil extends StatelessWidget {
  const HeaderUtil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.only(top: 35),
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        color: Color(0xff296DC8),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.indigo, Color(0xff296DC8)]),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3.0,
            offset: Offset(0.0, 5.0),
            spreadRadius: 3.0,
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.transparent,
            child: ListTile(
              title: const Text(
                'Bienvenido (a)',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                'Lista de usuario',
                style: TextStyle(color: Colors.white),
              ),
              leading:
                  Image.asset('assets/images/user3.png', width: 40, height: 40),
            ),
          ),
        ],
      ),
    );
  }
}
