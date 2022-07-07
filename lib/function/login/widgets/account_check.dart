import 'package:flutter/material.dart';

class AccountCheck extends StatelessWidget {

  final bool login;
  final VoidCallback press;

  const AccountCheck({Key? key, required this.login, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "还没有账户?" : "已有账户?",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "注册" : "登入",
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
