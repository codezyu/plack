import 'package:flutter/material.dart';

import '../../../../common/constants.dart';
import '../../sigup/sigup_screen.dart';
import '../../widgets/account_check.dart';

class Social extends StatelessWidget {
  const Social({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '或者',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
        ),
        AccountCheck(
          login: true,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignUpScreen();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
