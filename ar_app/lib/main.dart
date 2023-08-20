import 'package:ar_app/ar_earth_map_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AR App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ArEarthMapScreen(),
    );
  }
}

