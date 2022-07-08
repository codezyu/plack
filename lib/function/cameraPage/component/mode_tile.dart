import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../shared/colors.dart';
import '../shared/consts.dart';
import '../widgets/neumorphic_button.dart';

class ModeTile extends StatelessWidget {
  const ModeTile({
    Key? key,
    required this.name,
    required this.indicatorColor,
    required this.introduction,
    this.margin,
    this.pressed,
    this.onTap,
    this.disabled,
  }) : super(key: key);

  final EdgeInsetsGeometry? margin;
  final String name;
  final String introduction;
  final bool? pressed;
  final Color indicatorColor;
  final GestureTapCallback? onTap;
  final bool? disabled;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onTap: this.onTap,
      width: 150,
      disabled: disabled,
      margin: const EdgeInsets.only(
        left: GLOBAL_EDGE_MARGIN_VALUE,
        top: 15,
        bottom: 15,
      ),
      pressed: pressed,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          left: 8,
          right: 8,
          bottom: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _Indicator(
              color: indicatorColor,
            ),
            SizedBox(
              height: 6,
            ),
            Center(
              child: Text(
                name,
                semanticsLabel: name+','+introduction,
                style: TextStyle(
                  fontSize: 30,
                  color: CustomColors.primaryTextColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      padding: EdgeInsets.all(4.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color.withAlpha(70),
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
      ),
    );
  }
}
