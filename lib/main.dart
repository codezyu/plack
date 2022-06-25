import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plack/component/Init.dart';
import 'package:plack/function/aboutPage/aboutPage.dart';
import 'package:plack/function/cameraPage/cameraPage.dart';
import 'package:plack/function/drawerPage/drawerPage.dart';
import 'package:plack/function/login/Sigin/sigin_screen.dart';
import 'package:plack/function/login/sigup/sigup_screen.dart';
import 'package:plack/function/mainPage/mainpage.dart';
import 'package:plack/function/newsPage/newsPage.dart';
import 'package:plack/function/settingPage/settingPage.dart';

import 'common/config.dart';
import 'function/cameraPage/cameraScreen.dart';
import 'function/favouritePage/FavoritePage.dart';
import 'function/homePage/homePage.dart';

Future<void> main() async {
  try{
    //初始化相机
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    init();
  }catch(e){

  }
  //方向
  Future.delayed(Duration(milliseconds: 1)).then(
          (value) => SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFFF1F2F6),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Color(0xFFF1F2F6),
      )));
  Future.delayed(Duration(milliseconds: 1))
      .then((value) => SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]));
  runApp(
      Phoenix(
        child:ProviderScope(
        child: MaterialApp(
          //调试显示材质网格
          debugShowMaterialGrid: false,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Montserrat',
          ),
          initialRoute: '/home',
          routes: {
            '/home': (context) =>mainPage(),
            '/login':(context)=>SignInScreen(),
          },
        ),
      ),
      )
  );
}