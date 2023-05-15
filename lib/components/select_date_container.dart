import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/utils/constants.dart';
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
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                width: 1.5,
                color: addTaskViewModel.invalidDateTime
                    ? Colors.red.shade700
                    : Colors.grey,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            padding:
                const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  addTaskViewModel.date != null
                      ? DateFormat('dd/MM/yyyy').format(addTaskViewModel.date!)
                      : "Date",
                  style: TextStyles.defaultTextStyle,
                ),
                const Icon(
                  Icons.calendar_month,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
        addTaskViewModel.invalidDateTime
            ? Padding(
                padding: const EdgeInsets.only(top: 6, left: 11),
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
