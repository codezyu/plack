import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plack/component/Net/User.dart';
import 'package:plack/function/mainPage/mainpage.dart';

import '../../../../common/config.dart';
import '../../../../common/constants.dart';
import '../../widgets/rectangular_button.dart';
import '../../widgets/rectangular_input_field.dart';

class Credentials extends StatelessWidget {
  const Credentials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final username= TextEditingController();
    final password=TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RectangularInputField(
            hintText: 'Username',
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
          RectangularButton(text: 'Let\'s Start', press: ()async{
            signup(username.text, password.text).then((value){
              if(value==true){
                signin(username.text, password.text).then((value){
                  if(value==true){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return mainPage();
                        },
                      ),
                    );
                  }
                });
              }
            }
            );

          })
        ],
      ),
    );
  }
}
