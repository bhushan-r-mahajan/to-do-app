import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/components/pencil_icon_container.dart';
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
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.15,
      width: MediaQuery.of(context).size.width,
      child: Slidable(
        key: ValueKey(task.id),
        startActionPane: _buildActionPane(
          addTaskViewModel,
          complete,
          (context) {
            task.completed = !task.completed;
            addTaskViewModel.updateTask(task);
          },
        ),
        endActionPane: _buildActionPane(
          addTaskViewModel,
          delete,
          (context) async => await showDialog(
            context: context,
            builder: (context) => AppAlertDialog(
              title: delete,
              content: confirmDelete,
              onPressedOk: () {
                addTaskViewModel.deleteTask(task.id);
              },
            ),
          ),
        ),
        child: InkWell(
          onTap: () {
            addTaskViewModel.setTask(task);
            addTaskViewModel.setIsEditing(true);
            homeViewModel.navigateToAddTask();
          },
          child: Row(
            children: [
              const PencilIconContainer(),
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
                      style: TextStyles.defaultBoldLightTextStyle,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    )
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.only(top: 10),
                alignment: Alignment.topCenter,
                child: Text(
                  DateFormat('dd/MM/yyyy').format(
                    DateTime.parse(task.date),
                  ),
                  style: TextStyles.defaultLightTextStyle,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  ActionPane _buildActionPane(AddTaskViewModel addTaskViewModel,
      String actionType, Function(BuildContext) onPressed) {
    return ActionPane(
      extentRatio: 0.3,
      motion: const StretchMotion(),
      children: [
        SlidableAction(
          borderRadius: BorderRadius.circular(10),
          spacing: 0,
          onPressed: onPressed,
          backgroundColor: Colors.white,
          foregroundColor: actionType == delete
              ? Colors.red.shade600
              : Colors.green.shade600,
          icon: actionType == delete ? Icons.delete : Icons.done,
          label: actionType == delete
              ? delete
              : task.completed
                  ? "Incomplete"
                  : "Complete",
        ),
      ],
    );
  }
}
