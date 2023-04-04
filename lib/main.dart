import 'package:flutter/material.dart';
import 'package:my_chat/screen/home_screen.dart';

// flutter pub add flutter_svg
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'OpenSans',
      ),
      home: const HomeScreen(),
    );
  }
}
