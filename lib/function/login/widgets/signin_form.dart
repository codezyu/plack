import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plack/component/Net/User.dart';
import 'package:plack/controller/dataController.dart';
import 'package:plack/controller/userInfoController.dart';

import '../locator.dart';
import '../services/camera.service.dart';
import 'app_button.dart';

class SignInSheet extends StatelessWidget {
  SignInSheet({Key? key}) : super(key: key);
  final _cameraService = locator<CameraService>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              'Welcome back, ',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            child: Column(
              children: [
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                AppButton(
                  text: 'LOGIN',
                  onPressed: () async {
                    dataController data=Get.find();
                    userInfoController logic=Get.find();
                    logic.signIn(data.getUserName(), data.getPassword()).then((value){
                      Get.offNamed("/main");
                    });
                  },
                  icon: Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
