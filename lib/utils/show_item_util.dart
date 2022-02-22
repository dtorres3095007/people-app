import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class ShowItemUtil extends StatefulWidget {
  const ShowItemUtil({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.context,
    required this.callback,
    required this.img,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final dynamic context;
  final dynamic callback;
  final dynamic img;
  @override
  State<ShowItemUtil> createState() => _HeaderSecondaryUtilState();
}

class _HeaderSecondaryUtilState extends State<ShowItemUtil> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => widget.callback(),
      child: Stack(
        children: [
          Container(
            // width: size.width * 0.90,
            // margin: EdgeInsets.only(top: 0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1.0,
                  offset: Offset(0, 10),
                  spreadRadius: 1.0,
                )
              ],
            ),
            child: ListTile(
              title: Text(
                widget.title,
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                widget.subTitle,
                style: TextStyle(color: Colors.grey),
              ),
              leading: CircleAvatar(
                  backgroundColor: Colors.grey[200], child: widget.img),
            ),
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
