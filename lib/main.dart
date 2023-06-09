import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_chat/screen/camera_screen.dart';
import 'package:my_chat/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dummy/chats_dummy.dart';

// flutter pub add intl
// flutter pub add logger
// flutter pub add camera
// flutter pub add flutter_svg
// flutter pub add video_player
// flutter pub add shared_preferences
// flutter pub add emoji_picker_flutter

final logger = Logger();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  cameras = await availableCameras();
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
      home: const LoginScreen(),
    );
  }
}
