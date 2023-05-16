import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../services/navigation_services.dart';
import '../services/to_do_services.dart';

class AddTaskViewModel extends ChangeNotifier {
  //Variables
  Task? _task;
  DateTime? _date;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final FocusNode _titleFieldFocus = FocusNode();
  final FocusNode _descriptionFieldFocus = FocusNode();
  String _title = "";
  bool _completed = false;
  String _description = "";
  bool _invalidDateTime = false;
  bool _isEditing = false;
  bool _loading = false;
  TodoServices todoServices = TodoServices();
  bool _typing = false;

  //Getters
  bool get loading => _loading;
  bool get typing => _typing;
  bool get completed => _completed;
  Task? get task => _task;
  DateTime? get date => _date;
  String get title => _title;
  String get description => _description;
  bool get invalidDateTime => _invalidDateTime;
  bool get isEditing => _isEditing;
  GlobalKey<FormState> get formkey => _formkey;
  get titleController => _titleController;
  get descriptionController => _descriptionController;
  FocusNode get titleFieldFocus => _titleFieldFocus;
  FocusNode get descriptionFieldFocus => _descriptionFieldFocus;

  //Setters
  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setTyping(bool typing) async {
    _typing = typing;
    notifyListeners();
  }

  setCompleted(bool completed) async {
    _completed = completed;
    notifyListeners();
  }

  setDate(DateTime? date) {
    _date = date;
    notifyListeners();
  }

  setTask(Task task) {
    _task = task;
    notifyListeners();
  }

  setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  setInvalidDateTime(bool invalidDateTime) {
    _invalidDateTime = invalidDateTime;
    notifyListeners();
  }

  setIsEditing(bool isEditing) {
    if (isEditing) {
      titleController.text = task!.title;
      descriptionController.text = task!.description;
      setDate(DateTime.parse(task!.date));
    } else {
      titleController.clear();
      descriptionController.clear();
      setDate(null);
    }
    _isEditing = isEditing;
    notifyListeners();
  }

  updateTask(Task task) async {
    await todoServices.updateTask(
      id: task.id,
      title: task.title,
      description: task.description,
      date: task.date,
      completed: task.completed,
    );
  }

  pickDate(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setDate(date);
    }
  }

  deleteTask(String id) async {
    await todoServices.deleteTaskById(id);
    NavigationService.instance.goback();
  }

  void validateForm() async {
    setLoading(true);
    setInvalidDateTime(false);
    if (!formkey.currentState!.validate()) {
      if (date == null) {
        setInvalidDateTime(true);
        return;
      }
      return;
    }
    formkey.currentState!.save();
    if (isEditing) {
      await todoServices.updateTask(
        id: task!.id,
        title: title,
        description: description,
        date: '$date',
        completed: completed,
      );
    } else {
      await todoServices.addTask(title, description, '$date');
    }
    NavigationService.instance.goback();
    setLoading(false);
  }
}
