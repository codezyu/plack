import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plack/function/login/face/sign-up.dart';

import '../../../../common/constants.dart';

class FaceSocial extends StatelessWidget {
  const FaceSocial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'OR',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: appPadding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '想要人脸登录吗?',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            ),
            GestureDetector(
              onTap: (){
                Get.offNamed('/face');
              },
              child: Text(
                "人脸登录",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
