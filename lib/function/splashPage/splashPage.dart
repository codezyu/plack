import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:plack/controller/dataController.dart';
import 'package:plack/controller/speechController.dart';
import 'package:plack/controller/userInfoController.dart';

import '../../common/scaleFactor.dart';
import '../../component/Loading.dart';
import '../../controller/initController.dart';
import '../../controller/newsController.dart';
import '../../controller/ocrController.dart';
class splashPage  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image:new ExactAssetImage('assets/img/splashscreen/splashscreen.jpg'),
              fit: BoxFit.cover
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Loading(),
          SizedBox(height: 20,)
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
    Get.put<ocrController>(ocrController());
    Get.put<speechController>(speechController());
  }
}
