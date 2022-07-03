import 'dart:math';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plack/controller/ocrController.dart';
import 'package:plack/function/cameraPage/model/service_locator.dart';
import 'package:plack/function/cameraPage/shared/colors.dart';
import 'package:plack/function/cameraPage/shared/consts.dart';
import 'package:plack/function/cameraPage/shared/mode.dart';
import 'package:plack/function/newsPage/newsPage.dart';
import 'dart:io';
import '../../common/config.dart';
import '../../common/constants.dart';
import '../../common/providers.dart';
import '../../component/Loading.dart';
import '../../style/NeuButton.dart';
import 'Indicator.dart';
import 'component/mode_tile.dart';
import 'component/rollcase.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}
class _CameraPageState extends State<CameraPage> {
  ocrController logic=Get.find();
  late double screenWidth;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isBackPressed = false;
  double adjusted(double val) => val * screenWidth * perPixel;
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (isCameraOpen) {
      setState(() {
        isBackPressed = true;
        xOffset = adjusted(250);
        yOffset = adjusted(140);
        scaleFactor = 0.7;
        isDrawerOpen = true;
        isCameraOpen = false;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
          isCameraOpen ? Brightness.dark : Brightness.light,
          systemNavigationBarColor: isCameraOpen ? backgroundC[0] : drawerColor,
          systemNavigationBarIconBrightness:
          isCameraOpen ? Brightness.dark : Brightness.light,
          systemNavigationBarDividerColor:
          isCameraOpen ? backgroundC[0] : drawerColor,
        ));
      });
      return true;
    }
    else
      return false;
  }
  @override
  void dispose() {
    // player.dispose();
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }
  @override
  void initState(){
    ServiceLocator.init();
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    //后退拦截
    BackButtonInterceptor.add(myInterceptor);
    setState(() {
      xOffset = 250;
      yOffset = 140;
      isBackPressed = false;
      scaleFactor = 0.7;
      isDrawerOpen = true;
      isCameraOpen = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Consumer(
        builder: (context, ref, child) {
          Color backgroundColor = ref.watch(backgroundProvider);
          Color shadowColor = ref.watch(shadowProvider);
          Color lightShadowColor = ref.watch(lightShadowProvider);
          Color textColor = ref.watch(textProvider);
          bool isDark = ref.read(isDarkProvider);
          return ValueListenableBuilder(
            valueListenable: indexOfMenu,
            builder: (context, dynamic val, child) {
              if (!isCameraOpen && indexOfMenu.value == Menu['camera'] && !isBackPressed) {
                Future.delayed(Duration(microseconds: 1)).then((value) {
                  setState(() {
                    xOffset = 0;
                    yOffset = 0;
                    scaleFactor = 1;
                    isDrawerOpen = false;
                    isCameraOpen = true;
                  });
                });
              } else if (indexOfMenu.value != Menu['camera']) isBackPressed = false;
              return child!;
            },
            child: SafeArea(
              child: AnimatedContainer(
                  duration: Duration(milliseconds: drawerAnimDur),
                  curve: Curves.easeInOutQuart,
                  transform: Matrix4.translationValues(xOffset, yOffset, 100)
                    ..scale(scaleFactor),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  onEnd: (() {
                    if (isCameraOpen && indexOfMenu.value == Menu['camera']) {
                      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                        statusBarIconBrightness:
                        isCameraOpen ? Brightness.dark : Brightness.light,
                        systemNavigationBarColor:
                        isCameraOpen ? backgroundColor : drawerColor,
                        systemNavigationBarIconBrightness:
                        isCameraOpen ? Brightness.dark : Brightness.light,
                        systemNavigationBarDividerColor:
                        isCameraOpen ? backgroundColor : drawerColor,
                      ));
                    }
                  }),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(isDrawerOpen ? 28 : 0),
                  ),
                  child: GestureDetector(
                    onTap: (() {
                      if (!isCameraOpen && indexOfMenu.value == Menu['camera']) {
                        setState(() {
                          xOffset = 0;
                          yOffset = 0;
                          scaleFactor = 1;
                          isDrawerOpen = false;
                          isCameraOpen = true;
                        });
                      }
                    }),
                    onHorizontalDragEnd: ((_) {
                      if (!isCameraOpen && indexOfMenu.value == Menu['camera']) {
                        setState(() {
                          xOffset = 0;
                          yOffset = 0;
                          scaleFactor = 1;
                          isDrawerOpen = false;
                          isCameraOpen = true;
                        });
                      }
                    }),
                    child:AbsorbPointer(
                      absorbing: !isCameraOpen,
                      child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(isCameraOpen ? 0 : 28),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 10,
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 27),
                                        child: Text(
                                          '辅助功能',
                                          style: TextStyle(
                                            color: textColor,
                                            letterSpacing: 2.0,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      NeuButton(
                                        ico: Icon(
                                          Icons.menu_rounded,
                                          size: 30,
                                          color: textColor,
                                        ),
                                        onPress: (() {
                                          setState(() {
                                            FocusScope.of(context).unfocus();
                                            isBackPressed = true;
                                            xOffset = adjusted(250);
                                            yOffset = adjusted(140);
                                            scaleFactor = 0.7;
                                            isDrawerOpen = true;
                                            isCameraOpen = false;
                                            SystemChrome.setSystemUIOverlayStyle(
                                                SystemUiOverlayStyle(
                                                  statusBarColor: Colors.transparent,
                                                  statusBarIconBrightness: isCameraOpen
                                                      ? Brightness.dark
                                                      : Brightness.light,
                                                  systemNavigationBarColor: isCameraOpen
                                                      ? backgroundColor
                                                      : drawerColor,
                                                  systemNavigationBarIconBrightness:
                                                  isCameraOpen
                                                      ? Brightness.dark
                                                      : Brightness.light,
                                                  systemNavigationBarDividerColor:
                                                  isCameraOpen
                                                      ? backgroundColor
                                                      : drawerColor,
                                                ));
                                          });
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child:SizedBox(height: 10),
                              ),
                              Expanded(
                                flex:40,
                                  child:
                                  Stack(
                                    children: [
                                      Positioned(
                                        right: 0,
                                        child: Transform.translate(
                                          offset: Offset(100, 60),
                                          child: GetBuilder<ocrController>(
                                            builder: (logic){
                                              return RollCase(
                                                width: 300,
                                                height: 300,
                                                icon: logic.getIcon(),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: ocrController.margin,
                                            child: Text(
                                              'Plack',
                                              style: TextStyle(
                                                fontSize: 28,
                                                color: CustomColors.primaryTextColor,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                          Expanded(child: SizedBox(height: 2),),
                                          Padding(
                                            padding: ocrController.margin,
                                            child: Text(
                                              'with you',
                                              style: TextStyle(
                                                fontSize: 26,
                                                color: CustomColors.primaryTextColor,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex:5,
                                            child:SizedBox(height: 5),),
                                          Expanded(
                                            flex:3,
                                            child:  Padding(
                                                padding: ocrController.margin,
                                                child: GetBuilder<ocrController>(
                                                  builder: (logic){
                                                    return Indicator(
                                                      color: logic.selectedMode?.color,
                                                      blink: true,
                                                    );
                                                  },
                                                )
                                            ),),
                                          Expanded(
                                            flex:10,
                                            child:SizedBox(height: 10),),
                                          Expanded(
                                            flex:10,
                                            child:  Padding(
                                              padding: ocrController.margin,
                                              child: GetBuilder<ocrController>(
                                                builder: (logic){
                                                  return  ConstrainedBox(
                                                      constraints:BoxConstraints(
                                                        maxWidth: 100,
                                                      ),
                                                    child:
                                                      Text(
                                                    logic.selectedMode!.introduction,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: CustomColors.primaryTextColor,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ));
                                                },
                                              )
                                          ),),
                                          Expanded(
                                            flex:5,
                                            child:
                                            SizedBox(height: 40),
                                          ),
                                          Expanded(
                                            flex:35,
                                            child: _ModesList(),),
                                        ],
                                      ),
                                    ],
                                  ),
                              ),
                            ],
                          )
                      ),
                    ) ,

                  )
              ),
            )
          );
        }
    );
  }
}
class cameraBlinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ocrController>(ocrController());
  }
}
class _ModesList extends StatelessWidget {
  const _ModesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: ocrController.margin,
            child: Text(
              '功能',
              style: TextStyle(
                fontSize: 23,
                color: CustomColors.primaryTextColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 4),
          Flexible(
            child: GetBuilder<ocrController>(
              builder: (logic) {
                return ListView.builder(
                    itemCount: logic.nodes.length,
                    itemBuilder: (context, index) {
                      ModeItemModel item = logic.nodes[index];

                      return ModeTile(
                        pressed: logic.selectedMode == item,
                        indicatorColor: item.color,
                        name: item.name,
                        introduction: item.introduction,
                        disabled: false,
                        onTap: () => logic.selectMode(item,context),
                      );
                    },
                    scrollDirection: Axis.horizontal);
              },
            ),
          ),
        ],
      ),
    );
  }
}
