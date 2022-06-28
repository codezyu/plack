import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:plack/controller/dataController.dart';
import 'package:plack/controller/userInfoController.dart';
import '../../common/scaleFactor.dart';
import '../../controller/initController.dart';
import '../../controller/newsController.dart';
class splashPage  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.hourglass_bottom,
            size: 30.0,
          ),
          Text(
            'loading...',
            style: TextStyle(fontSize: 30.0),
          ),
        ],
      ),
    );
  }
}
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    print("ok");
    Get.put<initController>(initController());
    Get.put<dataController>(dataController());
    Get.put<userInfoController>(userInfoController());
    Get.put<newsController>(newsController());
  }
}
