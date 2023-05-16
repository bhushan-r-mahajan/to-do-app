// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/components/to_do_logo.dart';
import 'package:to_do_app/view_models/splash_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SplashViewModel splashViewModel = context.watch<SplashViewModel>();
    return const SafeArea(
      child: Scaffold(
        body: ToDoLogo(),
      ),
    );
  }
}
