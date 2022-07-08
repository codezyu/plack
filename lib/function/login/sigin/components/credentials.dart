import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plack/component/Loading.dart';
import 'package:plack/controller/speechController.dart';
import 'package:plack/function/mainPage/mainpage.dart';

import '../../../../common/config.dart';
import '../../../../common/constants.dart';
import '../../../../controller/userInfoController.dart';
import '../../widgets/rectangular_button.dart';
import '../../widgets/rectangular_input_field.dart';

class Credentials extends StatelessWidget {
  const Credentials({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    userInfoController logic=Get.find();
    final username= TextEditingController();
    final password=TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RectangularInputField(
            hintText: '用户名',
            icon: Icons.person,
            obscureText: false,
            controller: username,
          ),
          SizedBox(
            height: appPadding / 2,
          ),
          RectangularInputField(
            hintText: '密码',
            icon: Icons.lock,
            obscureText: true,
            controller: password,
          ),
          SizedBox(
            height: appPadding / 2,
          ),
          // Center(
          //   child: Text(
          //     'Forget Password?',
          //     style: TextStyle(
          //       fontWeight: FontWeight.w400,
          //       fontSize: 17,
          //     ),
          //   ),
          // ),
          RectangularButton(text: 'Connect the world',
              press: () async {
               speechController speech=Get.find();
                Loading.show(context);
                logic.signIn(username.text, password.text).then((value){
                  if(value==true){
                    speech.flutterTts.speak("欢迎使用");
                    Get.snackbar('欢迎', 'I\'m Plack Have a nice day');
                    indexOfMenu.value=Menu['favourite']!;
                    Get.offNamed('/main');
                  }else{
                    speech.flutterTts.speak("错误,请检查你的用户名和密码");
                    Get.snackbar('错误', '请检查你的用户名和密码');
                  }
                });
              })
        ],
      ),
    );
  }
}
