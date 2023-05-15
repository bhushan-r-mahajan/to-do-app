import 'package:flutter/material.dart';
import 'package:to_do_app/utils/constants.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    required this.onSaved,
    required this.controller,
  });

  final String hintText;
  final Function(String?) onSaved;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText can't be empty.";
        }
        return null;
      },
      onSaved: onSaved,
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundColor,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
