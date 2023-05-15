import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/components/app_alert_dialog.dart';
import 'package:to_do_app/components/task_tile.dart';
import 'package:to_do_app/view_models/home_screen_view_model.dart';
import '../components/error_fetching_tasks.dart';
import '../models/task_model.dart';
import '../utils/constants.dart';
import '../utils/text_styles.dart';
import '../view_models/add_task_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<List<Task>>? streamTasks;

  @override
  void initState() {
    HomeViewModel homeViewModel =
        Provider.of<HomeViewModel>(context, listen: false);
    streamTasks = homeViewModel.fetchTasks();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeViewModel.getUserName();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context);
    return SafeArea(
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                _buildHeader(homeViewModel),
                homeViewModel.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: _buildStreamBuilder(homeViewModel),
                      ),
              ],
            ),
          ),
          floatingActionButton: _buildFAB(homeViewModel),
        ),
      ),
    );
  }

  Widget _buildHeader(HomeViewModel homeViewModel) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.topCenter,
      width: width,
      child: Column(
        children: [
          _buildNameRow(homeViewModel),
          const SizedBox(height: 20),
          _buildDateRow(homeViewModel),
          const SizedBox(height: 20),
          _buildPercentageRow(homeViewModel),
        ],
      ),
    );
  }

  Row _buildDateRow(HomeViewModel homeViewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          DateFormat.yMMMMd().format(
            DateTime.now(),
          ),
          style: TextStyles.lightText,
        ),
        Column(
          children: [
            SizedBox(
              child: StreamBuilder(
                stream: streamTasks,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!;
                    return Text(
                      "${data.length}",
                      style: TextStyles.headerTextStyle,
                    );
                  }
                  return const Text(
                    "0",
                    style: TextStyles.headerTextStyle,
                  );
                },
              ),
            ),
            const Text(
              "Tasks",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNameRow(HomeViewModel homeViewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Welcome\n${toBeginningOfSentenceCase(homeViewModel.userName)}",
            style: TextStyles.headerName,
          ),
        ),
        InkWell(
          onTap: () => showDialog(
            context: context,
            builder: (context) => AppAlertDialog(
              title: logout,
              content: confirmLogout,
              onPressedOk: () => homeViewModel.signOut(),
            ),
          ),
          child: const Icon(
            Icons.logout,
            size: 30,
          ),
        ),
      ],
    );
  }

  Widget _buildPercentageRow(HomeViewModel homeViewModel) {
    return Container(
      alignment: Alignment.centerRight,
      child: StreamBuilder(
        stream: streamTasks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            var percentage = 0.0;
            if (data.isNotEmpty) {
              percentage = (data
                          .where((element) => element.completed == true)
                          .toList()
                          .length /
                      data.length) *
                  100;
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircularPercentIndicator(
                  radius: 12.0,
                  lineWidth: 4.0,
                  animation: true,
                  percent: percentage / 100,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: accentColor,
                ),
                const SizedBox(width: 10),
                Text(
                  "${percentage.toStringAsFixed(0)}% done",
                  style: TextStyles.lightText,
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildStreamBuilder(HomeViewModel homeViewModel) {
    return StreamBuilder<List<Task>>(
      stream: streamTasks,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const ErrorFetchingTasks();
        } else if (snapshot.hasData) {
          final tasks = snapshot.data;
          return tasks!.isEmpty
              ? const Center(
                  child: Text(
                    noTasks,
                    style: TextStyles.defaultBoldTextStyle,
                  ),
                )
              : _buildGroupedListView(tasks, homeViewModel);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildGroupedListView(List<Task> tasks, HomeViewModel homeViewModel) {
    return GroupedListView(
      elements: tasks,
      groupBy: (task) => task.date,
      useStickyGroupSeparators: false,
      groupSeparatorBuilder: (value) => Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Expanded(child: Divider(thickness: 2)),
            const SizedBox(width: 10),
            Text(
              DateUtils.isSameDay(DateTime.now(), DateTime.parse(value))
                  ? "Today"
                  : DateUtils.isSameDay(
                          DateTime.now().subtract(const Duration(days: 1)),
                          DateTime.parse(value))
                      ? "Yesterday"
                      : DateUtils.isSameDay(
                              DateTime.now().add(const Duration(days: 1)),
                              DateTime.parse(value))
                          ? "Tomorrow"
                          : DateFormat('dd/MM/yyyy').format(
                              DateTime.parse(value),
                            ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Divider(thickness: 2),
            ),
          ],
        ),
      ),
      itemBuilder: (context, task) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TaskTile(
          homeViewModel: homeViewModel,
          task: task,
        ),
      ),
    );
  }

  Widget _buildFAB(HomeViewModel homeViewModel) {
    return FloatingActionButton(
      backgroundColor: buttonColor,
      onPressed: () {
        AddTaskViewModel addTaskViewModel =
            Provider.of<AddTaskViewModel>(context, listen: false);
        addTaskViewModel.setIsEditing(false);
        homeViewModel.navigateToAddTask();
      },
      child: const Icon(
        Icons.add,
        size: 30,
      ),
    );
  }
}
