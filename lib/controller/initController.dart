import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:plack/controller/dataController.dart';
import 'package:plack/controller/userInfoController.dart';

import '../common/config.dart';
class initController extends GetxController{
  @override
  void onReady() {
    super.onReady();
    dataController data=Get.find();
    userInfoController user=Get.find();
    // //方向
    // Future.delayed(Duration(milliseconds: 1)).then(
    //         (value) => SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //       statusBarColor: Colors.transparent,
    //       statusBarIconBrightness: Brightness.dark,
    //       systemNavigationBarColor: Color(0xFFF1F2F6),
    //       systemNavigationBarIconBrightness: Brightness.dark,
    //       systemNavigationBarDividerColor: Color(0xFFF1F2F6),
    //     )));
    // Future.delayed(Duration(milliseconds: 1))
    //     .then((value) => SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]));
    if(data.getToken()==null||data.getToken().isEmpty){
      Get.offNamed('/login');
    }else{
      Get.offNamed('/main');
    }
  }
}