import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.labelText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          hintStyle: TextStyle(color: Colors.grey[500]), // Change hint color
          labelStyle: TextStyle(color: Colors.grey[500]), // Change label color
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.purple),
          ),
        ),
      ),
    );
  }
}
