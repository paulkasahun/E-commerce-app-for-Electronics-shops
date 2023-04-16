// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hinText;
  final int maxLines;
  final bool obsCureText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hinText,
    this.maxLines = 1, //default and not required everywhere
    required this.obsCureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsCureText,
      decoration: InputDecoration(
        hintText: hinText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Enter  $hinText";
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
