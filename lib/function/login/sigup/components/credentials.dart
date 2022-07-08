import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plack/controller/speechController.dart';
import 'package:plack/function/mainPage/mainpage.dart';

import '../../../../common/constants.dart';
import '../../../../component/Loading.dart';
import '../../../../controller/userInfoController.dart';
import '../../widgets/rectangular_button.dart';
import '../../widgets/rectangular_input_field.dart';

class Credentials extends StatelessWidget {
  const Credentials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic=Get.put(userInfoController());
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
          RectangularButton(text: '让我们开始吧', press: ()async{
            Loading.show(context);
            speechController speech=Get.find();
           logic.signUp(username.text, password.text).then((value) {
             if (value) {
               speech.flutterTts.speak('欢迎,'+'I\'m Plack Have a nice day');
               Get.snackbar('欢迎', 'I\'m Plack Have a nice day');
               Get.offNamed('/main');
             } else {
               speech.flutterTts.speak('注意,'+'请检查您的网络');
               Get.snackbar('错误', '网络连接错误');
             }
           });
          })
        ],
      ),
    );
  }
}
