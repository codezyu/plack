import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plack/controller/ocrController.dart';

import '../shared/colors.dart';

class RollCase extends StatefulWidget {
  const RollCase({
    Key? key,
    this.width,
    this.height,
    required this.icon,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Icon icon;
  @override
  _RollCaseState createState() => _RollCaseState();
}

class _RollCaseState extends State<RollCase> {
  ocrController logic=Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const circularBorder = const BorderRadius.all(Radius.circular(200));
    const ring1Offset = 35;
    const ring2Offset = 70;
    const ring3Offset = 28;

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.3, 0.07),
          end: Alignment(0.35, 1),
          colors: CustomColors.drumRing1Colors,
          stops: [0, 0.4, 1],
        ),
        border: Border.all(color: CustomColors.drumBorder, width: 2),
        borderRadius: circularBorder,
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(-8, -8),
            color: Colors.white.withAlpha(12),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: widget.width! - ring1Offset,
          height: widget.height! - ring1Offset,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.3, 0.07),
              end: Alignment(0.35, 1),
              colors: CustomColors.drumRing2Colors,
              stops: [0, 0.6, 1],
            ),
            borderRadius: circularBorder,
          ),
          child: Center(
            child: Container(
              width: widget.width! - ring1Offset - ring2Offset,
              height: widget.height! - ring1Offset - ring2Offset,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.36, 0.07),
                  end: Alignment(0.5, 0.6),
                  colors: CustomColors.drumRing3Colors,
                  stops: [0, 0.25, 1],
                ),
                borderRadius: circularBorder,
              ),
              child: Center(
                child: Container(
                  width:
                      widget.width! - ring1Offset - ring2Offset - ring3Offset,
                  height:
                      widget.height! - ring1Offset - ring2Offset - ring3Offset,
                  child: Container(
                    child: widget.icon
                  )
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
