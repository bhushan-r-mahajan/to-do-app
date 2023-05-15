import 'package:flutter/material.dart';
import 'package:to_do_app/services/google_services.dart';
import 'package:to_do_app/services/to_do_services.dart';
import 'package:to_do_app/utils/constants.dart';
import '../models/task_model.dart';
import '../services/navigation_services.dart';

class HomeViewModel extends ChangeNotifier {
  //Variables
  bool _loading = false;
  double _completedPercentage = 0.0;
  int _totalTasks = 0;
  String _userName = "";
  TodoServices todoServices = TodoServices();

  //Getters
  bool get loading => _loading;
  double get completedPercentage => _completedPercentage;
  int get totalTasks => _totalTasks;
  String get userName => _userName;

  //Setters
  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setCompletedPercentage(double completedPercentage) async {
    _completedPercentage = completedPercentage;
    notifyListeners();
  }

  setTotalTasks(int totalTasks) async {
    _totalTasks = totalTasks;
    notifyListeners();
  }

  setUserName(String userName) async {
    _userName = userName;
    notifyListeners();
  }

  //Functions
  Stream<List<Task>>? fetchTasks() => todoServices.fetchTasks();

  getUserName() {
    var user = GoogleServices.getCurrentUserName();
    setUserName(user);
  }

  navigateToAddTask() {
    NavigationService.instance.navigateTo(addTask);
  }

  signOut() async {
    setTotalTasks(0);
    await GoogleServices.googleSignOut();
    NavigationService.instance.navigateToReplacement(signIn);
  }
}
