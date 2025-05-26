import 'dart:async';
import 'package:bloc_flutter/bloc/auth/login_ui.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
          () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => LoginUiScreen()),
              ModalRoute.withName('/')
          )
    );
  }
}
