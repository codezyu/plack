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
import 'package:plack/function/newsPage/newsPage.dart';
import 'dart:io';
import '../../common/config.dart';
import '../../common/constants.dart';
import '../../common/providers.dart';
import '../../component/Loading.dart';
import '../../style/NeuButton.dart';

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                              flex: 13,
                                child:Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40, bottom: 5),
                                      child: Text(
                                        '点击使用相机',
                                        style: kTextStyle.copyWith(
                                          color: isDark ? Colors.white : Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    NeuButton(
                                      ico: Icon(
                                        Icons.photo_camera_back,
                                        size: 70,
                                        color: Colors.amberAccent,
                                      ),
                                      length: 150,
                                      breadth: 150,
                                      radii: 50,
                                      onPress: (() async{
                                        pickCamera();
                                      }),
                                    ),
                                  ],
                                ),
                            ),
                            Expanded(
                              flex: 1,
                                child: SizedBox()),
                            Expanded(
                              flex:13,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40, bottom: 5),
                                      child: Text(
                                        '图库',
                                        style: kTextStyle.copyWith(
                                          color: isDark ? Colors.white : Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    NeuButton(
                                      ico: Icon(
                                        Icons.photo,
                                        size: 70,
                                        color: Colors.greenAccent,
                                      ),
                                      length: 150,
                                      breadth: 150,
                                      radii: 50,
                                      onPress: (){pickImage();},
                                    ),
                                  ],
                                ),
                            ),
                            Expanded(
                              flex:1,
                              child: SizedBox(),
                            ),
                          ],
                        )
                    ),
                  ) ,

                )
            ),
          );
        }
    );
  }
  Future pickImage() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      logic.image=File(image.path);
      createPage();
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }
  Future pickCamera() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null) return;
      logic.image=File(image.path);
      createPage();
    } on PlatformException catch(e) {
      print('Failed to pick camera: $e');
    }
  }
  void createPage() {
    Loading.show(context);
    logic.getOCR().then((value) {
      Loading.dismiss(context);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return NewsPage(id: -1,
              title: 'OCR识别结果',
              author: 'plack',
              type: 'ocr',
              content: value);
        },
      ));
    });
  }

}
class cameraBlinding extends Bindings {
  @override
  void dependencies() {
    print("ok");
    Get.put<ocrController>(ocrController());
  }
}