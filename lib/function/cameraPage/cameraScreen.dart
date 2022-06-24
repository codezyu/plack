import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/config.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  bool _isCameraInitialized = false;
  //释放内存
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  @override
  void initState() {
    //隐藏系统状态栏
    SystemChrome.setEnabledSystemUIOverlays([]);
    onNewCameraSelected(cameras[0]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraInitialized
          ? AspectRatio(
        aspectRatio: 1 / controller!.value.aspectRatio,
        child: controller!.buildPreview(),
      )
          : Container(),
    );
  }
  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    // Dispose the previous controller
    await previousCameraController?.dispose();
    // Replace with the new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }
    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });
    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }
}