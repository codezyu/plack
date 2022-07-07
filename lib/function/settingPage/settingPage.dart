import 'dart:ui';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focused_menu/modals.dart';

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
  List<FocusedMenuItem> deviceModeFocused = <FocusedMenuItem>[];
  List<DisplayMode> modes = <DisplayMode>[];
  //保存数据
  bool isBackPressed = false;
  Future? _refreshFunc;
  bool isRefresh = false;

  Future<DisplayMode> getCurrentMode() async {
    return await FlutterDisplayMode.active;
  }

  @override
  void initState() {
    _refreshFunc = _getRefresh(null, null);
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

  Future<List<FocusedMenuItem>> _getRefresh(
      Color? textColor, Color? backgroundColor) async {
    deviceModeFocused = [];
    await Future.delayed(Duration(microseconds: 10)).then((_) async {
      try {
        //存在问题
        DisplayMode m = await FlutterDisplayMode.active;
        print(m);
        modes = await FlutterDisplayMode.supported;
        print('modes $modes of $m');
        final DisplayMode current = await FlutterDisplayMode.active;
        modes = modes.sublist(1);
        modes.forEach((element) {
          deviceModeFocused.add(
            FocusedMenuItem(
              title: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  '${element.toString().substring(3)}',
                  style: TextStyle(
                    color: textColor ?? textC[0],
                    fontFamily: 'MontserratBold',
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              onPressed: () async {
                await FlutterDisplayMode.setPreferredMode(element);
                Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text(
                        'Please Restart the app to apply the changes')));
                selected = element;
                if (mounted) {
                  setState(() {});
                }
              },
              trailingIcon: Icon(
                Icons.circle,
                color: current.id == element.id
                    ? textColor ?? textC[0]
                    : backgroundColor ?? backgroundC[0],
              ),
            ),
          );
        });
      } on PlatformException catch (e) {
        print(e);
      }
    });
    return deviceModeFocused;
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
                child: AbsorbPointer(
                  absorbing: !isSettingsOpen,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(isSettingsOpen ? 0 : 28),
                    ),
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
                                Colors.purple[700]!
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
                                  [Colors.pinkAccent[100]!, Colors.pink[800]!])),
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
                                110, [Colors.greenAccent, Colors.teal]),
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
                                [Colors.orangeAccent, Colors.deepOrange]
                                as List<Color>),
                          ),
                          Column(
                            // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //图标
                                Expanded(
                                  flex: isRefresh ? 13 : 12,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 40, top: 50),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Settings',
                                          style: TextStyle(
                                            color: textColor,
                                            letterSpacing: 2.0,
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          color: Colors.transparent,
                                          onPressed: (() {
                                            setState(() {
                                              isBackPressed = true;
                                              xOffset = adjusted(250);
                                              positionOffset = 70;
                                              yOffset = adjusted(140);
                                              scaleFactor = 0.7;
                                              isDrawerOpen = true;
                                              isSettingsOpen = false;
                                              SystemChrome
                                                  .setSystemUIOverlayStyle(
                                                  SystemUiOverlayStyle(
                                                    statusBarColor:
                                                    Colors.transparent,
                                                    statusBarIconBrightness:
                                                    isSettingsOpen
                                                        ? Brightness.dark
                                                        : Brightness.light,
                                                    systemNavigationBarColor:
                                                    isSettingsOpen
                                                        ? backgroundColor
                                                        : drawerColor,
                                                    systemNavigationBarIconBrightness:
                                                    isSettingsOpen
                                                        ? Brightness.dark
                                                        : Brightness.light,
                                                    systemNavigationBarDividerColor:
                                                    isSettingsOpen
                                                        ? backgroundColor
                                                        : drawerColor,
                                                  ));
                                            });
                                          }),
                                          padding: EdgeInsets.only(right: 35),
                                          iconSize: 40,
                                          icon: Icon(
                                            Icons.menu_rounded,
                                            size: 40,
                                            color: textColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(flex: 2, child: SizedBox()),
                                Expanded(
                                  flex: isRefresh ? 14 : 16,
                                  child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 350),
                                    reverseDuration: Duration(milliseconds: 350),
                                    switchInCurve: Curves.easeOutBack,
                                    switchOutCurve: Curves.easeOutBack,
                                    transitionBuilder:
                                        (Widget child, Animation<double> anim) =>
                                        ScaleTransition(
                                          scale: anim,
                                          child: child,
                                        ),
                                    child: isDark
                                        ? Container()
                                        : ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30)),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 10,
                                          sigmaY: 10,
                                        ),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width -
                                              60,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end:
                                                  Alignment.bottomRight,
                                                  colors: [
                                                    Colors.white
                                                        .withOpacity(0.4),
                                                    Colors.white
                                                        .withOpacity(0.01),
                                                  ]),
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(30)),
                                              border: Border.all(
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                              )),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 30,
                                                      top: 30),
                                                  child: Text(
                                                    '超高对比度模式',
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: TextStyle(
                                                      color: textColor,
                                                      letterSpacing: 1.0,
                                                      fontSize: textSize,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      bottom: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: SizedBox(),
                                                      ),
                                                      Expanded(
                                                        flex: 10,
                                                        child:
                                                        GestureDetector(
                                                          onTap: (() async {
                                                            setState((){
                                                              textC[0]=Colors.black87;
                                                              textSize=26;
                                                              isContrast=false;
                                                            });
                                                          }),
                                                          child:
                                                          AnimatedContainer(
                                                            duration: Duration(
                                                                milliseconds:
                                                                200),
                                                            curve: Curves
                                                                .easeOutQuint,
                                                            width: (MediaQuery.of(context).size.width -
                                                                60) /
                                                                3 -
                                                                15,
                                                            height: 70,
                                                            decoration:
                                                            BoxDecoration(
                                                              color: !isContrast!
                                                                  ? textColor
                                                                  .withOpacity(
                                                                  0.5)
                                                                  : Colors
                                                                  .transparent,
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                      0.8)),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  20),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'Off',
                                                                style:
                                                                TextStyle(
                                                                  color: !isContrast!
                                                                      ? backgroundColor
                                                                      : textColor,
                                                                  letterSpacing:
                                                                  2.0,
                                                                  fontSize:
                                                                  20,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: SizedBox(),
                                                      ),
                                                      Expanded(
                                                        flex: 10,
                                                        child:
                                                        GestureDetector(
                                                          onTap: (() async {
                                                            setState((){
                                                              textC[0]=Colors.black;
                                                              textSize=30;
                                                              isContrast=true;
                                                            });
                                                          }),
                                                          child:
                                                          AnimatedContainer(
                                                            duration: Duration(
                                                                milliseconds:
                                                                200),
                                                            curve: Curves
                                                                .easeOutQuint,
                                                            width: (MediaQuery.of(context).size.width -
                                                                60) /
                                                                3 -
                                                                15,
                                                            height: 70,
                                                            decoration:
                                                            BoxDecoration(
                                                              color: isContrast!
                                                                  ? textColor
                                                                  .withOpacity(
                                                                  0.5)
                                                                  : Colors
                                                                  .transparent,
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                      0.8)),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  20),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'On',
                                                                style:
                                                                TextStyle(
                                                                  color: isContrast!
                                                                      ? backgroundColor
                                                                      : textColor,
                                                                  letterSpacing:
                                                                  2.0,
                                                                  fontSize:
                                                                  20,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: SizedBox(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(flex: 20, child: SizedBox()),
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