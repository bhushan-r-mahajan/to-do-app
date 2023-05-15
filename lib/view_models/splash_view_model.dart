import 'package:flutter/widgets.dart';

import '../services/google_services.dart';
import '../services/navigation_services.dart';
import '../utils/constants.dart';

class SplashViewModel extends ChangeNotifier {
  SplashViewModel() {
    checkIfUserLoggedIn();
  }

  checkIfUserLoggedIn() async {
    await Future.delayed(
      const Duration(seconds: 4),
      () async {
        bool loggedIn = await GoogleServices.checkIfUserIsAlreadyLoggedIn();
        NavigationService.instance
            .navigateToReplacement(loggedIn ? home : signIn);
      },
    );
  }
}
