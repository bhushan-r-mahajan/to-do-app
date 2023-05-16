import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/view_models/add_task_view_model.dart';

import '../utils/text_styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    required this.onSaved,
    required this.controller,
    required this.focusNode,
  });

  final String hintText;
  final Function(String?) onSaved;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    AddTaskViewModel addTaskViewModel = context.watch<AddTaskViewModel>();
    return TextFormField(
      controller: controller,
      onChanged: (value) => addTaskViewModel.setTyping(value.isNotEmpty),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText can't be empty.";
        }
        return null;
      },
      onSaved: onSaved,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.2),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade700, width: 2.2),
        ),
        hintText: hintText,
        hintStyle: TextStyles.hintTextStyle,
        suffixIcon: controller.text.isNotEmpty && addTaskViewModel.typing
            ? InkWell(
                onTap: () => controller.clear(),
                child: Icon(
                  Icons.cancel_sharp,
                  color: Colors.grey[400],
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
