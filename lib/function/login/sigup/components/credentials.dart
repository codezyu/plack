import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plack/function/mainPage/mainpage.dart';

import '../../../../common/constants.dart';
import '../../widgets/rectangular_button.dart';
import '../../widgets/rectangular_input_field.dart';

class Credentials extends StatelessWidget {
  const Credentials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RectangularInputField(
            hintText: 'Username',
            icon: Icons.person,
            obscureText: false,
          ),
          SizedBox(
            height: appPadding / 2,
          ),
          RectangularInputField(
            hintText: 'Password',
            icon: Icons.lock,
            obscureText: true,
          ),
          SizedBox(
            height: appPadding / 2,
          ),
          RectangularButton(text: 'Let\'s Start', press: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return mainPage();
                },
              ),
            );
          })
        ],
      ),
    );
  }
}
