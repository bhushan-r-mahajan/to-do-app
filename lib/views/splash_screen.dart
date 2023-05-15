// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/components/to_do_logo.dart';
import 'package:to_do_app/view_models/splash_view_model.dart';

import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SplashViewModel splashViewModel = context.watch<SplashViewModel>();
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
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: ToDoLogo(),
        ),
      ),
    );
  }
}
