import 'package:flutter/material.dart';

class NeumorphicCard extends StatelessWidget {
  late Widget content;
  NeumorphicCard(this.content);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 120,
      margin: EdgeInsets.only(right: 30),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          const Radius.circular(12),
        ),
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 0.2),
        ),
        color: const Color.fromRGBO(239, 238, 238, 1),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(217, 210, 200, 0.51),
            offset: Offset(6, 6),
            blurRadius: 16,
          ),
          BoxShadow(
            color: Color.fromRGBO(255, 255, 255, 0.83),
            offset: Offset(-6, -6),
            blurRadius: 16,
          ),
        ],
      ),
      child: content,
    );
  }
}