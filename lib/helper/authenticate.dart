
import 'package:flutter/material.dart';

import '../screens/welcome_screen/ui/welcome_screen.dart';
import '../screens/sign_up_screen/ui/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return WelcomeScreen(toggleView);
    } else {
      return SignUpScreen();
    }
  }
}

