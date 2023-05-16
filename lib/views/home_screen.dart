import 'package:flutter/material.dart';
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

  final GlobalKey<ScaffoldState> _key = GlobalKey();

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
      child: Scaffold(
        key: _key,
        drawer: _buildDrawerMenu(homeViewModel),
        body: Column(
          children: [
            _buildHeader(homeViewModel),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                "INBOX",
                style: TextStyles.defaultBoldLightTextStyle,
              ),
            ),
            _buildStreamBuilder(homeViewModel),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "COMPLETED",
                      style: TextStyles.defaultBoldLightTextStyle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: StreamBuilder(
                        stream: streamTasks,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var tasks = snapshot.data!;
                            var completed = tasks
                                .where((element) => element.completed == true)
                                .toList()
                                .length;
                            return Text(
                              "$completed",
                              style: const TextStyle(color: Colors.white),
                            );
                          } else {
                            return const Text(
                              "0",
                              style: TextStyle(color: Colors.white),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: _buildFAB(homeViewModel),
      ),
    );
  }

  Widget _buildDrawerMenu(HomeViewModel homeViewModel) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                "Welcome\n${toBeginningOfSentenceCase(homeViewModel.userName)}",
                style: TextStyles.headerName,
              ),
            ),
            const Divider(thickness: 2),
            InkWell(
              onTap: () => showDialog(
                context: context,
                builder: (context) => AppAlertDialog(
                  title: logout,
                  content: confirmLogout,
                  onPressedOk: () => homeViewModel.signOut(),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: const Text(
                  logout,
                  style: TextStyles.defaultBoldTextStyle,
                ),
              ),
            ),
            const Divider(thickness: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(HomeViewModel homeViewModel) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            headerImage,
          ),
        ),
      ),
      alignment: Alignment.topCenter,
      width: width,
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => _key.currentState!.openDrawer(),
                child: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 32,
                ),
              )
            ],
          ),
          const SizedBox(height: 25),
          _buildYourActivityRow(homeViewModel),
          const SizedBox(height: 40),
          _buildDateRow(homeViewModel),
          const SizedBox(height: 30),
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
          style: TextStyles.headerLightTextStyle,
        ),
        _buildPercentage(homeViewModel),
      ],
    );
  }

  Widget _buildYourActivityRow(HomeViewModel homeViewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            "Your\nThings",
            style: TextStyle(
              fontSize: 44,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
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
                  } else {
                    return const Text(
                      "0",
                      style: TextStyles.headerTextStyle,
                    );
                  }
                },
              ),
            ),
            const Text(
              "Tasks",
              style: TextStyles.headerLightTextStyle,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPercentage(HomeViewModel homeViewModel) {
    return Container(
      alignment: Alignment.centerRight,
      child: StreamBuilder(
        stream: streamTasks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _showPercentage(snapshot.data!);
          } else {
            return _showPercentage([]);
          }
        },
      ),
    );
  }

  Widget _showPercentage(List<Task> tasks) {
    var percentage = 0.0;
    if (tasks.isNotEmpty) {
      percentage =
          (tasks.where((element) => element.completed == true).toList().length /
                  tasks.length) *
              100;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircularPercentIndicator(
          radius: 12.0,
          lineWidth: 2.0,
          animation: true,
          percent: percentage / 100,
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: buttonColor,
        ),
        const SizedBox(width: 10),
        Text(
          "${percentage.toStringAsFixed(0)}% done",
          style: TextStyles.defaultLightTextStyle,
        ),
      ],
    );
  }

  Widget _buildStreamBuilder(HomeViewModel homeViewModel) {
    return StreamBuilder<List<Task>>(
      stream: streamTasks,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final tasks = snapshot.data;
          return homeViewModel.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : tasks!.isEmpty
                  ? const Center(
                      child: Text(
                        noTasks,
                        style: TextStyles.defaultBoldTextStyle,
                      ),
                    )
                  : _buildGroupedListView(tasks, homeViewModel);
        } else {
          return const ErrorFetchingTasks();
        }
      },
    );
  }

  Widget _buildGroupedListView(List<Task> tasks, HomeViewModel homeViewModel) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: tasks
            .map(
              (e) => Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    TaskTile(homeViewModel: homeViewModel, task: e),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2),
                  ],
                ),
              ),
            )
            .toList(),
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
