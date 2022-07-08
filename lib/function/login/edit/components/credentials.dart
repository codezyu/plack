import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plack/component/Loading.dart';
import 'package:plack/controller/speechController.dart';
import 'package:plack/function/mainPage/mainpage.dart';

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
            hintText: '旧密码',
            icon: Icons.lock_outline,
            obscureText: false,
            controller: username,
          ),
          SizedBox(
            height: appPadding / 2,
          ),
          RectangularInputField(
            hintText: '新密码',
            icon: Icons.lock,
            obscureText: true,
            controller: password,
          ),
          SizedBox(
            height: appPadding / 2,
          ),
          RectangularButton(text: 'ReConnect the World',
              press: () async {
            speechController speech=Get.find();
                if(username.text==password.text){
                  speech.flutterTts.speak('注意，新旧密码不能相同');
                  Get.snackbar('提示', '新旧密码不能相同');
                  return;
                }
                Loading.show(context);
                logic.editPassword(username.text, password.text).then((value){
                  Loading.dismiss(context);
                  if(value==0){
                    Get.snackbar('欢迎', 'Have a nice Day!');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return mainPage();
                        },
                      ),
                    );
                  }else if(value==1){
                    Get.snackbar('错误', '请检查密码是否输入正确');
                  }
                  else{
                    Get.snackbar('错误', '请检查您的网络连接');
                  }
                });
              })
        ],
      ),
    );
  }
}
