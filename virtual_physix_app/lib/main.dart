import 'package:flutter/material.dart';

import 'Screens/ar_cam_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Physics App', // Update the title
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // Use primarySwatch for consistent color
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ArCamScreen(), // Set ArCamScreen as the initial screen
    );
  }
}
