import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:plack/function/cameraPage/cameraPage.dart';
import 'package:plack/function/drawerPage/drawerPage.dart';
import 'package:plack/function/login/Sigin/sigin_screen.dart';
import 'package:plack/function/login/face/sign-in.dart';
import 'package:plack/function/login/locator.dart';
import 'package:plack/function/login/sigup/sigup_screen.dart';
import 'package:plack/function/splashPage/splashPage.dart';

import 'common/config.dart';
import 'function/cameraPage/model/service_locator.dart';
import 'function/favouritePage/FavoritePage.dart';
import 'function/homePage/homePage.dart';
import 'function/mainPage/mainPage.dart';

Future<void> main() async {
  try{
    await Hive.initFlutter();
    // Hive.registerAdapter(ContactAdapter());
    await Hive.openBox(userInfo);
    await Hive.openBox<List>("faceinfo");
    //初始化相机
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    setupServices();
    ServiceLocator.init();
  }catch(e){
  }
  runApp(
     Phoenix(child: ProviderScope(
         child:GetMaterialApp(
           smartManagement: SmartManagement.onlyBuilder,
           debugShowCheckedModeBanner: false,
           theme: ThemeData(
             fontFamily: 'Montserrat',
           ),
           initialRoute: '/init',
           getPages: [
             GetPage(name: '/login', page: () => SignInScreen()),
             GetPage(name: '/signup', page: () => SignUpScreen()),
             GetPage(name: '/main', page: () => mainPage()),
             GetPage(name: '/drawer', page: ()=>drawerPage()),
             GetPage(name: '/home', page: ()=>HomePage()),
             GetPage(name:'/init',page:()=>splashPage(),binding: SplashBinding()),
             GetPage(name:'/camera',page:()=>CameraPage()),
             GetPage(name:'/face',page:()=>SignIn()),
             GetPage(name:'/favourite',page:()=>FavoritePage()),
           ],
         )
     ))
  );
}