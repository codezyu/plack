import 'package:flutter/material.dart';
import 'package:plack/function/login/face/sign-up.dart';

import '../../../../common/constants.dart';

class FaceSocial extends StatelessWidget {
  const FaceSocial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: appPadding,
        ),
        Text(
          '或者',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUp();
                    },
                  ),
                );
              },
              child: Text(
                "人脸认证",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
