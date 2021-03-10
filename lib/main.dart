import 'package:bloc_sample/di/locator.dart';
import 'package:bloc_sample/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  locatorSetUp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}
