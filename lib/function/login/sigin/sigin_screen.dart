import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/constants.dart';
import '../../../controller/dataController.dart';
import 'components/Facesocial.dart';
import 'components/credentials.dart';
import 'components/head_text.dart';
import 'components/social.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dataController logic=Get.find();
    var data=logic.getFace();
    print(data);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            lightPrimary,
            darkPrimary,
          ]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadText(),
              Credentials(),
              Social(),
              data!=null?FaceSocial():SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
