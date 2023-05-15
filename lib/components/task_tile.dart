import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/view_models/add_task_view_model.dart';
import 'package:to_do_app/view_models/home_screen_view_model.dart';

import '../models/task_model.dart';
import '../utils/constants.dart';
import '../utils/text_styles.dart';
import 'app_alert_dialog.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.homeViewModel, required this.task});

  final HomeViewModel homeViewModel;
  final Task task;

  @override
  Widget build(BuildContext context) {
    AddTaskViewModel addTaskViewModel =
        Provider.of<AddTaskViewModel>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      height: MediaQuery.of(context).size.width * 0.15,
      width: MediaQuery.of(context).size.width,
      child: Slidable(
        key: ValueKey(task.id),
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(10),
              spacing: 0,
              onPressed: (context) async {
                await showDialog(
                  context: context,
                  builder: (context) => AppAlertDialog(
                    title: delete,
                    content: confirmDelete,
                    onPressedOk: () {
                      addTaskViewModel.deleteTask(task.id);
                    },
                  ),
                );
              },
              backgroundColor: Colors.white,
              foregroundColor: Colors.red.shade600,
              icon: Icons.delete,
              label: delete,
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            addTaskViewModel.setTask(task);
            addTaskViewModel.setIsEditing(true);
            homeViewModel.navigateToAddTask();
          },
          child: Row(
            children: [
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: task.completed,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  activeColor: Colors.purple,
                  onChanged: (value) {
                    task.completed = !task.completed;
                    addTaskViewModel.updateTask(task);
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      task.title,
                      style: task.completed
                          ? TextStyles.completedTextStyle
                          : TextStyles.defaultBoldTextStyle,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      task.description,
                      softWrap: true,
                      style: TextStyles.defaultLightTextStyle,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    )
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                DateFormat('dd/MM/yyyy').format(
                  DateTime.parse(task.date),
                ),
                style: TextStyles.lightText,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
