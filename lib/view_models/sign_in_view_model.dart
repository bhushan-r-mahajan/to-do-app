import 'package:flutter/material.dart';
import 'package:to_do_app/services/google_services.dart';
import 'package:to_do_app/services/navigation_services.dart';

import '../utils/constants.dart';

class SignInViewModel extends ChangeNotifier {
  //Variables
  //final NavigationService _navigationService = locator<NavigationService>();
  bool _loading = false;

  //Getters
  bool get loading => _loading;

  //Setters
  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  //Functions
  signIn() async {
    setLoading(true);
    bool success = await GoogleServices.googleSignIn();
    if (success) {
      NavigationService.instance.navigateToReplacement(home);
    }
    setLoading(false);
  }
}
