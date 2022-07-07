import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plack/component/Loading.dart';
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
            hintText: 'username',
            icon: Icons.person,
            obscureText: false,
            controller: username,
          ),
          SizedBox(
            height: appPadding / 2,
          ),
          RectangularInputField(
            hintText: 'Password',
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
                Loading.show(context);
                logic.signIn(username.text, password.text).then((value){
                  if(value==true){
                    Get.snackbar('欢迎', 'I\'m Plack Have a nice day');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return mainPage();
                        },
                      ),
                    );
                  }else{
                    Get.snackbar('错误', '请检查你的用户名和密码');
                  }
                });
              })
        ],
      ),
    );
  }
}
