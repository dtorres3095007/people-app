import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class HeaderSecondaryUtil extends StatefulWidget {
  const HeaderSecondaryUtil({
    Key? key,
    required this.title,
    required this.context,
    this.callback,
  }) : super(key: key);

  final String title;
  final dynamic context;
  final dynamic callback;
  @override
  State<HeaderSecondaryUtil> createState() => _HeaderSecondaryUtilState();
}

class _HeaderSecondaryUtilState extends State<HeaderSecondaryUtil> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
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
            child: _createHeaderItems(widget.context, widget.title),
          ),
        ],
      ),
    );
  }

  Widget _createHeaderItems(context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: widget.callback == null ? null : () => widget.callback(),
          child: widget.callback == null
              ? Container()
              : const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 30,
                ),
        ),
      ],
    );
  }
}
