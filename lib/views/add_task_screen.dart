import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/components/app_textfield.dart';
import 'package:to_do_app/components/select_date_container.dart';
import 'package:to_do_app/utils/constants.dart';
import 'package:to_do_app/view_models/add_task_view_model.dart';

import '../components/app_button.dart';
import '../models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, this.task});
  final Task? task;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    AddTaskViewModel addTaskViewModel = context.watch<AddTaskViewModel>();
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            color: backgroundColor,
            image: DecorationImage(
              image: AssetImage(backdrop),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text("Add a task"),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
              elevation: 0,
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: addTaskViewModel.formkey,
                child: Column(
                  children: [
                    AppTextField(
                      hintText: title,
                      onSaved: (value) => addTaskViewModel.setTitle(value!),
                      controller: addTaskViewModel.titleController,
                    ),
                    const SizedBox(height: 30),
                    AppTextField(
                      hintText: description,
                      onSaved: (value) =>
                          addTaskViewModel.setDescription(value!),
                      controller: addTaskViewModel.descriptionController,
                    ),
                    const SizedBox(height: 30),
                    SelectDateContainer(addTaskViewModel: addTaskViewModel),
                    const SizedBox(height: 30),
                    AppButton(
                      onPressed: () async => addTaskViewModel.validateForm(),
                      buttonText: save,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
