import 'package:flutter/cupertino.dart';
import 'package:plack/function/cameraPage/shared/colors.dart';

class Indicator extends StatefulWidget {
  const Indicator({
    Key? key,
    this.color,
    this.blink,
  }) : super(key: key);

  final Color? color;
  final bool? blink;

  @override
  IndicatorState createState() => IndicatorState();
}

class IndicatorState extends State<Indicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _colorTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );

    setupAnimation();
  }

  @override
  void didUpdateWidget(Indicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.color != oldWidget.color || widget.blink != oldWidget.blink) {
      setupAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setupAnimation() {
    Color? startColor = CustomColors.primaryTextColor.withAlpha(150);
    Color endColor = CustomColors.primaryTextColor.withAlpha(150);
    if (widget.color != null) {
      startColor = widget.color;
    }

    _controller.reset();
    _colorTween =
        ColorTween(begin: startColor, end: endColor).animate(_controller);
    if (widget.blink == true) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      padding: EdgeInsets.all(8.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: CustomColors.indicatorBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: -Offset(6, 6),
            color: CustomColors.containerShadowTop,
          ),
          BoxShadow(
            blurRadius: 10,
            offset: Offset(6, 6),
            color: CustomColors.containerShadowBottom,
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: _colorTween,
        builder: (context, child) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: _colorTween.value,
            ),
          );
        },
      ),
    );
  }
}
