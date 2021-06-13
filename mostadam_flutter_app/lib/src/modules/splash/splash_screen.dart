


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mostadam_flutter_app/src/components/SharedPreference.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/ui/login_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginView())));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(backgroundColor: Colors.black),
      ),
    );
  }
}
