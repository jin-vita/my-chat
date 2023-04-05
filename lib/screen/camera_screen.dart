import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/screen/video_screen.dart';
import 'package:my_chat/screen/view_screen.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> cameraValue;
  bool isRecording = false;
  bool isFlash = false;
  bool isFront = false;
  double transform = 0;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) => snapshot.connectionState == ConnectionState.done
                  ? CameraPreview(_controller)
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            _bottomButtons(context),
          ],
        ),
      ),
    );
  }

  _bottomButtons(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            isRecording ? const SizedBox() : const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    if (isFront) return;
                    setState(() {
                      isFlash = !isFlash;
                      isFlash
                          ? _controller.setFlashMode(FlashMode.torch)
                          : _controller.setFlashMode(FlashMode.off);
                    });
                  },
                  icon: isFlash
                      ? const Icon(
                          Icons.flash_on,
                          color: Colors.yellowAccent,
                          size: 28,
                        )
                      : const Icon(
                          Icons.flash_off,
                          color: Colors.white,
                          size: 28,
                        ),
                ),
                GestureDetector(
                  onLongPress: () async {
                    await _controller.startVideoRecording();
                    setState(() {
                      isRecording = true;
                    });
                  },
                  onLongPressUp: () async {
                    await _controller.stopVideoRecording().then((XFile file) {
                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => VideoScreen(
                              path: file.path,
                            ),
                          ),
                        );
                      }
                    });
                    setState(() {
                      isRecording = false;
                    });
                  },
                  onTap: () => _takePhoto(context),
                  child: isRecording
                      ? const Icon(
                          Icons.radio_button_on,
                          color: Colors.red,
                          size: 80,
                        )
                      : const Icon(
                          Icons.panorama_fish_eye,
                          color: Colors.white,
                          size: 70,
                        ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFront = !isFront;
                      if (isFront) {
                        isFlash = false;
                      }
                      transform = transform + pi;
                    });
                    _controller = CameraController(cameras[isFront ? 1 : 0], ResolutionPreset.high);
                    cameraValue = _controller.initialize();
                  },
                  icon: Transform.rotate(
                    angle: transform,
                    child: const Icon(
                      Icons.flip_camera_ios,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              'Hold for video, tap for photo',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _takePhoto(BuildContext context) async {
    if (isRecording) return;
    await _controller.takePicture().then(
      (XFile file) {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => ViewScreen(
                path: file.path,
              ),
            ),
          );
        }
      },
    );
  }
}
