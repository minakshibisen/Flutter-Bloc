import 'dart:async';
import 'package:bloc_flutter/ui/login_screen.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
          () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
              ModalRoute.withName('/')
          )
    );
  }
}
