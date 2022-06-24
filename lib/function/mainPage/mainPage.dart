import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plack/common/scaleFactor.dart';
import 'package:plack/function/aboutPage/aboutPage.dart';
import 'package:plack/function/cameraPage/cameraPage.dart';
import 'package:plack/function/favouritePage/FavoritePage.dart';
import 'package:plack/function/newsPage/newsPage.dart';
import 'package:plack/function/settingPage/settingPage.dart';

import '../../common/config.dart';
import '../../common/constants.dart';
import '../../common/providers.dart';
import '../drawerPage/drawerPAge.dart';
import '../homePage/homePage.dart';

class mainPage extends StatefulWidget {
  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage>{
  //should be adapted to the mobile
  DisplayMode? selected;
  List<DisplayMode> modesList = <DisplayMode>[];
  int? refreshId = 1;
  Future<bool> fetchModes() async {
    try {
      modesList = await FlutterDisplayMode.supported;
    } on PlatformException catch (e) {
      print(e);
    }
    selected = await FlutterDisplayMode.active;
    return true;
  }
  @override
  void initState() {
    super.initState();
  }
  //adapt to the screen
  late double screenWidth;
  double adjusted(double val) => val * screenWidth * perPixel;
  Future<bool?> _getData(WidgetRef ref) async {
    return false;
  }
  //设置点击两次退出
  late DateTime _lastQuitTime;
  @override
  Widget build(BuildContext context) {
    //adapt
    SizeConfig().init(context);
    screenWidth = MediaQuery.of(context).size.width;
    //退出管理
    return WillPopScope(
      onWillPop: () async{
        // if (_lastQuitTime == null ||
        //     DateTime
        //         .now()
        //         .difference(_lastQuitTime)
        //         .inSeconds > 1){
        //   Scaffold.of(context)
        //       .showSnackBar(SnackBar(content: Text('再按一次 Back 按钮退出')));
        //   _lastQuitTime = DateTime.now();
        //   return false;
        // }else{
        //   return true;
        // }
        return true;
      },
      //状态管理
      child: Consumer(
        builder: (context, ref, child){
          bool isDark=ref.read(isDarkProvider);
          Color backgroundColor = ref.watch(backgroundProvider);
          Color shadowColor = ref.watch(shadowProvider);
          //异步任务构造
          return FutureBuilder(
              future: _getData(ref),
              //context实际上就是element对象
              //AsyncSnapshot异步计算
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    //添加图片
                    child: Image.asset(
                      'assets/img/splashscreen/splashscreen.jpg',
                      width: screenWidth / 5,
                    ),
                  );
                } else {
                  return Scaffold(
                    backgroundColor: drawerColor,
                    body: Stack(
                        children: [
                          drawerPage(),
                          //层叠布局
                          ValueListenableBuilder<int>(
                            //监听对象
                              valueListenable: indexOfMenu,
                              // _表示使用该参数
                              builder:(context, value, _) {
                                return IndexedStack(
                                  index: indexOfMenu.value,
                                  children: [
                                    HomePage(),
                                    FavoritePage(),
                                    CameraPage(),
                                    AboutPage(),
                                    SettingsPage(),
                                    SettingsPage(),
                                  ],
                                );
                              }
                          )
                        ]
                    ),
                  );
                }
              }
          );
        },
      ),
    );
  }

}