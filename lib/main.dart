import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase_options.dart';
import 'package:to_do_app/services/navigation_services.dart';
import 'package:to_do_app/utils/constants.dart';
import 'package:to_do_app/view_models/add_task_view_model.dart';
import 'package:to_do_app/view_models/home_screen_view_model.dart';
import 'package:to_do_app/view_models/sign_in_view_model.dart';
import 'package:to_do_app/view_models/splash_view_model.dart';
import 'package:to_do_app/views/add_task_screen.dart';
import 'package:to_do_app/views/home_screen.dart';
import 'package:to_do_app/views/sign_in_screen.dart';
import 'package:to_do_app/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => SplashViewModel()),
        ChangeNotifierProvider(create: (_) => AddTaskViewModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: splash,
        routes: {
          addTask: (BuildContext context) => const AddTaskScreen(),
          signIn: (BuildContext context) => const SignInScreen(),
          home: (BuildContext context) => const HomeScreen(),
          splash: (BuildContext context) => const SplashScreen(),
        },
        navigatorKey: NavigationService.instance.navigationKey,
      ),
    );
  }
}
