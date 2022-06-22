import 'dart:ui';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/colorEllipse.dart';
import '../../common/config.dart';
import '../../common/constants.dart';
import '../../common/providers.dart';
//设置界面
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}
class _SettingsPageState extends State<SettingsPage> {
  late double screenWidth;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  double positionOffset = 70;


  bool isBackPressed = false;
  Future? _refreshFunc;
  bool isRefresh = false;

  Future<DisplayMode> getCurrentMode() async {
    return await FlutterDisplayMode.active;
  }

  @override
  void initState() {
    // _refreshFunc = _getRefresh(null, null);
    BackButtonInterceptor.add(myInterceptor);
    setState(() {
      xOffset = 250;
      isBackPressed = false;
      yOffset = 140;
      scaleFactor = 0.7;
      isDrawerOpen = true;
      isSettingsOpen = false;
    });
  }

  double adjusted(double val) => val * screenWidth * perPixel;

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (isSettingsOpen) {
      setState(() {
        isBackPressed = true;
        xOffset = adjusted(250);
        yOffset = adjusted(140);
        positionOffset = 70;
        scaleFactor = 0.7;
        isDrawerOpen = true;
        isSettingsOpen = false;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
          isSettingsOpen ? Brightness.dark : Brightness.light,
          systemNavigationBarColor:
          isSettingsOpen ? backgroundC[0] : drawerColor,
          systemNavigationBarIconBrightness:
          isSettingsOpen ? Brightness.dark : Brightness.light,
          systemNavigationBarDividerColor:
          isSettingsOpen ? backgroundC[0] : drawerColor,
        ));
      });
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Consumer(
        builder: (context, ref, child) {
          bool isDark = ref.read(isDarkProvider);
          Color backgroundColor = ref.watch(backgroundProvider);
          Color shadowColor = ref.watch(shadowProvider);
          Color lightShadowColor = ref.watch(lightShadowProvider);
          Color textColor = ref.watch(textProvider);
          return ValueListenableBuilder(
            valueListenable: indexOfMenu,
            builder: (context, dynamic val, child) {
              if (!isSettingsOpen && indexOfMenu.value == 4 && !isBackPressed) {
                Future.delayed(Duration(microseconds: 1)).then((value) {
                  setState(() {
                    xOffset = 0;
                    yOffset = 0;
                    positionOffset = 0;
                    scaleFactor = 1;
                    isDrawerOpen = false;
                    isSettingsOpen = true;
                  });
                });
              } else if (indexOfMenu.value != 4) isBackPressed = false;
              return child!;
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: drawerAnimDur),
              //动画效果
              curve: Curves.easeInOutQuart,
              //移动，缩放
              transform: Matrix4.translationValues(xOffset, yOffset, 100)
                ..scale(scaleFactor),
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              onEnd: (() {
                if (isSettingsOpen && indexOfMenu.value == Menu['setting']) {
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness:
                    isSettingsOpen ? Brightness.dark : Brightness.light,
                    systemNavigationBarColor:
                    isSettingsOpen ? backgroundColor : drawerColor,
                    systemNavigationBarIconBrightness:
                    isSettingsOpen ? Brightness.dark : Brightness.light,
                    systemNavigationBarDividerColor:
                    isSettingsOpen ? backgroundColor : drawerColor,
                  ));
                }
              }),
              decoration: BoxDecoration(
                color: isDark ? Colors.black : backgroundColor,
                borderRadius: BorderRadius.circular(isDrawerOpen ? 28 : 0),
              ),
              child: GestureDetector(
                onTap: (() {
                  if (!isSettingsOpen && indexOfMenu.value == Menu['setting']) {
                    setState(() {
                      xOffset = 0;
                      yOffset = 0;
                      positionOffset = 0;
                      scaleFactor = 1;
                      isDrawerOpen = false;
                      isSettingsOpen = true;
                    });
                  }
                }),
                onHorizontalDragEnd: ((_) {
                  if (!isSettingsOpen && indexOfMenu.value == 4) {
                    setState(() {
                      xOffset = 0;
                      yOffset = 0;
                      positionOffset = 0;
                      scaleFactor = 1;
                      isDrawerOpen = false;
                      isSettingsOpen = true;
                    });
                  }
                }),
                //禁止用户输入
                child: AbsorbPointer(
                  absorbing: !isSettingsOpen,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(isSettingsOpen ? 0 : 28),
                    ),
                    //裁剪超出部分
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                          Radius.circular(isSettingsOpen ? 0 : 28)),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.easeInOutBack,
                              left: 10 - positionOffset,
                              bottom: -70 - positionOffset,
                              child: ColoredEllipse(250, [
                                Colors.purpleAccent[200]!,
                                Colors.purple[100]!
                              ])),
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.easeInOutBack,
                            right: -150 - positionOffset,
                            bottom: screenWidth / 2 + 100,
                            child: ColoredEllipse(250, [
                              Color.fromRGBO(179, 255, 171, 1),
                              Color.fromRGBO(18, 255, 247, 1)
                            ]),
                          ),
                          AnimatedPositioned(
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.easeInOutBack,
                              left: screenWidth / 2 - 90 - positionOffset,
                              bottom: 200 - positionOffset,
                              child: ColoredEllipse(150,
                                  [
                                    Colors.pinkAccent[100]!,
                                    Colors.pink[100]!
                                  ])),
                          AnimatedPositioned(
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.easeInOutBack,
                              right: -70 - positionOffset,
                              bottom: screenWidth / 2 - 100 - positionOffset,
                              child: ColoredEllipse(150, [mango[1], mango[0]])),
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.easeInOutBack,
                            right: -50 - positionOffset,
                            top: 80 - positionOffset,
                            child: ColoredEllipse(200, [sea.last, sea.first]),
                          ),
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.easeInOutBack,
                            left: screenWidth / 2 - 50 - positionOffset,
                            top: 300 - positionOffset,
                            child: ColoredEllipse(
                                110, [Colors.greenAccent, Colors.teal[100]!]),
                          ),
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.easeInOutBack,
                            left: 40 - positionOffset,
                            top: 70 - positionOffset,
                            child:
                            ColoredEllipse(150, [sunset.last, sunset.first]),
                          ),
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.easeInOutBack,
                            left: -20 - positionOffset,
                            top: 350,
                            child: ColoredEllipse(
                                140,
                                [Colors.orangeAccent, Colors.deepOrange[200]!]
                                as List<Color>),
                          ),
                          Column(
                            // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}