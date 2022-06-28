import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plack/controller/dataController.dart';
import 'package:plack/function/aboutPage/aboutPage.dart';
import 'package:plack/function/cameraPage/cameraPage.dart';
import 'package:plack/function/drawerPage/drawerPage.dart';
import 'package:plack/function/login/Sigin/sigin_screen.dart';
import 'package:plack/function/login/sigup/sigup_screen.dart';
import 'package:plack/function/mainPage/mainpage.dart';
import 'package:plack/function/newsPage/newsPage.dart';
import 'package:plack/function/savedPage/savedPage.dart';
import 'package:plack/function/settingPage/settingPage.dart';
import 'package:plack/function/splashPage/splashPage.dart';

import 'common/config.dart';
import 'function/cameraPage/cameraScreen.dart';
import 'function/favouritePage/FavoritePage.dart';
import 'function/homePage/homePage.dart';

Future<void> main() async {
  try{
    await Hive.initFlutter();
    // Hive.registerAdapter(ContactAdapter());
    await Hive.openBox(userInfo);
    //初始化相机
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
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
             GetPage(name: '/main', page: () => mainPage()),
             GetPage(name: '/drawer', page: ()=>drawerPage()),
             GetPage(name: '/news', page: ()=>HomePage()),
             GetPage(name:'/init',page:()=>splashPage(),binding: SplashBinding())
           ],
         )
     ))
  );
}