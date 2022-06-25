import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../common/constants.dart';
import '../sigup/components/credentials.dart';
import '../sigup/components/head_text.dart';
import '../sigup/components/social.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            ],
          ),
        ),
      ),
    );
  }
}
