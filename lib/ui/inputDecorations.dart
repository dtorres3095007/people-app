// ignore_for_file: file_names
import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration formsInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black12,
        ),
      ),

      // focusedBorder: const UnderlineInputBorder(
      //   borderSide: BorderSide(
      //     color: Colors.blue,
      //     width: 2,
      //   ),
      // ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey,
      ),
      prefixIcon: prefixIcon != null
          ? Icon(
              prefixIcon,
              color: const Color(0xff296DC8),
            )
          : null,
    );
  }

  static InputDecoration formsInputDecorationWhite({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.white,
      ),
      prefixIcon: prefixIcon != null
          ? Icon(
              prefixIcon,
              color: Colors.white,
            )
          : null,
    );
  }

  static InputDecoration formsInputDecorationLogin({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      // border: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(25.0),
      //   borderSide: const BorderSide(),
      // ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff296DC8),
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff296DC8),
          width: 1,
        ),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Color(0xff296DC8),
      ),
      prefixIcon: prefixIcon != null
          ? Icon(
              prefixIcon,
              color: Color(0xff296DC8),
            )
          : null,
    );
  }

  static FloatingActionButton floatingButtonDecoration(
    context,
    String page,
  ) {
    return FloatingActionButton(
      backgroundColor: const Color(0xff296DC8),
      onPressed: () => Navigator.pushNamed(context, page),
      child: const Icon(Icons.add),
    );
  }
}
