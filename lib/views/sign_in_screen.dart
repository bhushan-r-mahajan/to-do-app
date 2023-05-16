import 'package:flutter/material.dart';
import 'package:to_do_app/utils/constants.dart';
import 'package:to_do_app/view_models/sign_in_view_model.dart';
import 'package:provider/provider.dart';

import '../components/app_button.dart';
import '../components/to_do_logo.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  @override
  Widget build(BuildContext context) {
    SignInViewModel signInViewModel = context.watch<SignInViewModel>();
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: const ToDoLogo(),
                ),
              ),
              signInViewModel.loading
                  ? const CircularProgressIndicator()
                  : AppButton(
                      onPressed: () async {
                        signInViewModel.signIn();
                      },
                      buttonText: signInButtonText,
                      assetImage: googleLogo,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
