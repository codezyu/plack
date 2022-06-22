import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plack/function/homePage/CategoryCard.dart';
import 'package:plack/style/NeuCard.dart';

import '../../common/config.dart';
import '../../common/constants.dart';
import '../../common/providers.dart';
import '../../models/CategoryModel.dart';
import 'getCategories.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState()=> _HomePageState();

}
class _HomePageState extends State<HomePage>{
  bool isBackPressed = false;
  late double screenWidth;
  //缩放系数
  double scaleFactor = 1;
  double xOffset = 0;
  double yOffset = 0;
  double _opacity = 0;
  List<CategoryModel> categories=<CategoryModel>[];
  @override
  void initState() {
    super.initState();
    categories=getCategories();
  }
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    child: Column(
                        children:[
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 70,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categories.length,
                                  itemBuilder: (context,index){
                                    //return CategoryCard(imageAssetUrl: categories[index].url, categoryName: categories[index].name);
                                    return NeumorphicCard(CategoryCard(imageAssetUrl: categories[index].url, categoryName: categories[index].name));
                                  }
                              )
                          ),
                        ])
                )
            )
        )

    );
    // return Consumer(
    //     builder: (context, ref, child){
    //       bool isDark = ref.read(isDarkProvider);
    //       Color backgroundColor = ref.watch(backgroundProvider);
    //       Color shadowColor = ref.watch(shadowProvider);
    //       Color lightShadowColor = ref.watch(lightShadowProvider);
    //       Color textColor = ref.watch(textProvider);
    //       return ValueListenableBuilder(
    //           valueListenable: indexOfMenu,
    //           builder: (context, dynamic val, child){
    //             if (!isHomeOpen && indexOfMenu.value == 0 && !isBackPressed) {
    //
    //             } else if (indexOfMenu.value != Menu['home']) isBackPressed = false;
    //             return child!;
    //           },
    //           child: AnimatedContainer(
    //             padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
    //             duration: Duration(milliseconds: drawerAnimDur),
    //             curve: Curves.easeInOutQuart,
    //             transform: Matrix4.translationValues(xOffset, yOffset, 100)
    //               ..scale(scaleFactor),
    //             height: MediaQuery.of(context).size.height,
    //             width: double.infinity,
    //             onEnd: (() {
    //               if (isHomeOpen && indexOfMenu.value == Menu['home']) {
    //                 SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //                   statusBarColor: Colors.transparent,
    //                   // isHomeOpen
    //                   //     ? backgroundColor
    //                   //     : drawerColor,
    //                   statusBarIconBrightness:
    //                   isHomeOpen ? Brightness.dark : Brightness.light,
    //                   systemNavigationBarColor:
    //                   isHomeOpen ? backgroundColor : drawerColor,
    //                   systemNavigationBarIconBrightness:
    //                   isHomeOpen ? Brightness.dark : Brightness.light,
    //                   systemNavigationBarDividerColor:
    //                   isHomeOpen ? backgroundColor : drawerColor,
    //                 ));
    //               }
    //             }),
    //             decoration: BoxDecoration(
    //               color: backgroundColor,
    //               borderRadius: BorderRadius.circular(isHomeOpen ? 0 : 28),
    //             ),
    //             child: GestureDetector(
    //               onTap: (() {
    //                 if (!isHomeOpen && indexOfMenu.value == 0) {
    //                   setState(() {
    //                     xOffset = 0;
    //                     yOffset = 0;
    //                     scaleFactor = 1;
    //                     isDrawerOpen = false;
    //                     isHomeOpen = true;
    //                   });
    //                 }
    //               }),
    //               onHorizontalDragEnd: ((_) {
    //                 if (!isHomeOpen && indexOfMenu.value == 0) {
    //                   setState(() {
    //                     xOffset = 0;
    //                     yOffset = 0;
    //                     scaleFactor = 1;
    //                     isDrawerOpen = false;
    //                     isHomeOpen = true;
    //                   });
    //                 }
    //               }),
    //               //淡入淡出效果
    //               child:AnimatedOpacity(
    //                   duration: Duration(milliseconds: 200),
    //                   //1为完全可见
    //                   opacity: _opacity,
    //                   child: AbsorbPointer(
    //                     absorbing: !isHomeOpen,
    //                     child: Column(
    //                       children: [
    //                         //Categories
    //                         Container(
    //                           padding: EdgeInsets.symmetric(horizontal: 16),
    //                           height: 70,
    //                           child: ListView.builder(
    //                               scrollDirection: Axis.horizontal,
    //                               itemCount: categories.length,
    //                               itemBuilder: (context,index){
    //                                 return CategoryCard(imageAssetUrl: categories[index].url, categoryName: categories[index].name);
    //                               }
    //                           ),
    //                         )
    //                       ],
    //                     )
    //                   )
    //               ),
    //             ),
    //           )
    //       );
    //     }
    // );
  }

}