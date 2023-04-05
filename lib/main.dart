import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/screen/camera_screen.dart';
import 'package:my_chat/screen/home_screen.dart';

// flutter pub add camera
// flutter pub add flutter_svg
// flutter pub add video_player
// flutter pub add shared_preferences
// flutter pub add emoji_picker_flutter
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: const HomeScreen(),
    );
  }
}
