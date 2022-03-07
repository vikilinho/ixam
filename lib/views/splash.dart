import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ixam/views/home_screen.dart';
import 'package:ixam/views/validation_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

var finalPass;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // loadData();
    getMyTk().whenComplete(() async {
      Timer(
          Duration(milliseconds: 0),
          () =>
              Get.to(finalPass == null ? ()  => HomeScreen() : NewValidationScreen()));
    });
    super.initState();
  }

  Future getMyTk() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenObtained = prefs.getString('pass');
    print(tokenObtained);
    setState(() {
      finalPass = tokenObtained;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color.fromRGBO(28, 180, 174, 1),
        );
  }
}
