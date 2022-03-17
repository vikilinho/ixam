import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ixam/controller/locator.dart';
import 'package:ixam/views/home_screen.dart';
import 'package:ixam/views/signature.dart';
import 'package:ixam/views/splash.dart';
import 'package:ixam/views/validation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/HomeScreen': (context) => HomeScreen(),
        '/SplashScreen': (context) => SplashScreen(),
        '/NewValidationScreen': (context) => NewValidationScreen(),
        "/SignatureScreen": (context) => SignatureScreen(),
      },
      initialRoute: '/SplashScreen',
    );
  }
}
