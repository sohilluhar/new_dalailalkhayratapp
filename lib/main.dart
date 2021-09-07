import 'package:flutter/material.dart';

import 'Home.dart';
import 'Screens/onboarding.dart';
import 'Screens/splash_screen.dart';
import 'common/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: SplashScreen(),
    );
  }
}
