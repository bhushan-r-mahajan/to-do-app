import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/view_models/add_task_view_model.dart';

import '../utils/text_styles.dart';

class SelectDateContainer extends StatelessWidget {
  const SelectDateContainer({super.key, required this.addTaskViewModel});
  final AddTaskViewModel addTaskViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            addTaskViewModel.pickDate(context);
          },
          child: Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: addTaskViewModel.invalidDateTime
                      ? Colors.red.shade700
                      : Colors.grey.shade500,
                  width: 2,
                ),
              ),
            ),
            child: addTaskViewModel.date != null
                ? Text(
                    DateFormat('dd/MM/yyyy').format(addTaskViewModel.date!),
                    style: TextStyles.defaultTextStyle,
                  )
                : Text(
                    "Date",
                    style: TextStyles.hintTextStyle,
                  ),
          ),
        ),
        addTaskViewModel.invalidDateTime
            ? Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  "Date can't be empty.",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.red.shade700,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
