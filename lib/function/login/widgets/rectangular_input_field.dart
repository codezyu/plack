import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import 'neumorphic_text_field_container.dart';


class RectangularInputField extends StatelessWidget {

  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController  controller;
  const RectangularInputField({Key? key,required this.hintText, required this.icon, required this.obscureText, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicTextFieldContainer(
      child: TextField(
        cursorColor: black,
        obscureText: obscureText,
        controller: this.controller,
        decoration: InputDecoration(
          hintText: hintText,
          helperStyle: TextStyle(
            color: black.withOpacity(0.7),
            fontSize: 18,
          ),
          prefixIcon: Icon(icon,color: black.withOpacity(0.7),size: 20,),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
