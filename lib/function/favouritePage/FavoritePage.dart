import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plack/function/homePage/homePage.dart';
import 'package:plack/function/login/edit/edit_screen.dart';
import 'package:plack/function/mainPage/mainpage.dart';
import 'package:plack/function/savedPage/savedPage.dart';

import '../../common/config.dart';
import '../../common/constants.dart';
import '../../common/providers.dart';
import '../../component/Loading.dart';
import '../../controller/newsController.dart';
import '../../controller/userInfoController.dart';
import '../../style/NeuButton.dart';
import '../../style/innerShadow.dart';

class FavoritePage extends StatefulWidget{
  @override
  _FavoritePageState createState()=>_FavoritePageState();

}
class _FavoritePageState extends State<FavoritePage>{
  userInfoController logic=Get.find();
  newsController data=Get.find();
  ValueNotifier<String> _titleName = ValueNotifier<String>('我的信息');
  late Animation<Color?> colAnim1, colAnim2;
  TextEditingController dialogController = TextEditingController();
  double _opacity = 1;
  late double screenWidth;
  late double cardHeight=MediaQuery.of(context).size.height/3*2;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isBackPressed = false;
  List<String>? savedList = [];

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    logic.getNums();
    screenWidth = MediaQuery.of(context).size.width;
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
              if (!isFavouriteOpen && indexOfMenu.value == Menu['favourite'] && !isBackPressed) {
                Future.delayed(Duration(microseconds: 1)).then((value) {
                  setState(() {
                    xOffset = 0;
                    yOffset = 0;
                    scaleFactor = 1;
                    isDrawerOpen = false;
                    isFavouriteOpen = true;
                  });
                });
              } else if (indexOfMenu.value != Menu['favourite']) isBackPressed = false;
              return child!;
            },
            child: AnimatedContainer(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              duration: Duration(milliseconds: drawerAnimDur),
              curve: Curves.easeInOutQuart,
              transform: Matrix4.translationValues(xOffset, yOffset, 100)
                ..scale(scaleFactor),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              onEnd: (() {
                if (isFavouriteOpen && indexOfMenu.value == Menu['favourite']) {
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness:
                    isFavouriteOpen ? Brightness.dark : Brightness.light,
                    systemNavigationBarColor:
                    isFavouriteOpen ? backgroundColor : drawerColor,
                    systemNavigationBarIconBrightness:
                    isFavouriteOpen ? Brightness.dark : Brightness.light,
                    systemNavigationBarDividerColor:
                    isFavouriteOpen ? backgroundColor : drawerColor,
                  ));
                }
              }),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(isDrawerOpen ? 28 : 0),
              ),
              child: GestureDetector(
                onTap: (() {
                  if (!isFavouriteOpen && indexOfMenu.value == Menu['favourite']) {
                    setState(() {
                      xOffset = 0;
                      yOffset = 0;
                      scaleFactor = 1;
                      isDrawerOpen = false;
                      isFavouriteOpen = true;
                    });
                  }
                }),
                onHorizontalDragEnd: ((_) {
                  if (!isFavouriteOpen && indexOfMenu.value == Menu['favourite']) {
                    setState(() {
                      xOffset = 0;
                      yOffset = 0;
                      scaleFactor = 1;
                      isDrawerOpen = false;
                      isFavouriteOpen = true;
                    });
                  }
                }),
                child: AnimatedOpacity(
                    duration: Duration(milliseconds: 200),
                    //1为完全可见
                    opacity: _opacity,
                    child: AbsorbPointer(
                      //根据页 面是否打开确定是否可以点击
                      absorbing: !isFavouriteOpen,
                      child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(isFavouriteOpen ? 0 : 28),
                          ),
                          child:Column(
                            // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //界面标题和菜单按钮
                              Expanded(
                                flex: 6,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 27),
                                      child: ValueListenableBuilder<String>(
                                        valueListenable: _titleName,
                                        builder: (context, value, child) {
                                          return Text(
                                            _titleName.value,
                                            style: TextStyle(
                                              color: textColor,
                                              letterSpacing: 2.0,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    //层叠布局
                                    Stack(
                                      children: [
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
                                              xOffset = 250;
                                              yOffset = 140;
                                              scaleFactor = 0.7;
                                              isDrawerOpen = true;
                                              isFavouriteOpen = false;
                                              SystemChrome.setSystemUIOverlayStyle(
                                                  SystemUiOverlayStyle(
                                                    statusBarColor: Colors.transparent,
                                                    statusBarIconBrightness: isHomeOpen
                                                        ? Brightness.dark
                                                        : Brightness.light,
                                                    systemNavigationBarColor: isHomeOpen
                                                        ? backgroundColor
                                                        : drawerColor,
                                                    systemNavigationBarIconBrightness:
                                                    isHomeOpen
                                                        ? Brightness.dark
                                                        : Brightness.light,
                                                    systemNavigationBarDividerColor:
                                                    isHomeOpen
                                                        ? backgroundColor
                                                        : drawerColor,
                                                  ));
                                            });
                                          }),
                                        ),
                                        if (!openedAfterDbUpdate)
                                          Positioned(
                                            // draw a red marble
                                            top: 0.0,
                                            right: 15.0,
                                            child: new Icon(Icons.brightness_1_rounded,
                                                size: 15.0, color: Colors.redAccent),
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              //间隔
                              Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex:30,
                                child:NotificationListener(
                                  child: AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      margin: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 20),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      height:  cardHeight,
                                      width: screenWidth,
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        // gradient: LinearGradient(
                                        //     colors: gradientList[index % 5],
                                        //     begin: Alignment.centerLeft,
                                        //     end: Alignment.centerRight),
                                        borderRadius: BorderRadius.circular(32),
                                        boxShadow: [
                                          BoxShadow(
                                              color: shadowColor,
                                              offset: Offset(8, 6),
                                              blurRadius: 12),
                                          BoxShadow(
                                              color: lightShadowColor,
                                              offset: Offset(-8, -6),
                                              blurRadius: 12),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex:15,
                                                child: Text(
                                                  logic.userInfo.userName!,
                                                  style: kTextStyle.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                    color: Colors.amber,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Expanded(
                                                flex:4,
                                                child: NeuButton(
                                                  ico: Icon(
                                                    Icons.edit_note,
                                                    size: 30,
                                                    color: textColor,
                                                  ),
                                                  onPress: (){
                                                    Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) {
                                                        return EditScreen();
                                                      },
                                                    ));
                                                  },
                                                ),),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          //阅读数
                                          Container(
                                            decoration: ConcaveDecoration(
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                  lerpDouble(
                                                      0, 100, 0.25)!,
                                                ),
                                              ),
                                              colors: [
                                                shadowColor,
                                                lightShadowColor
                                              ],
                                              depression: 10,
                                            ),
                                            width: screenWidth - 40,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal: 0),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0,
                                                horizontal: 5),
                                            child: Container(
                                              child: Theme(
                                                data: Theme.of(context).copyWith(
                                                    dividerColor:  Colors.transparent
                                                ),
                                                child: ExpansionTile(
                                                  childrenPadding:
                                                  EdgeInsets.only(bottom: 10),
                                                  maintainState: true,
                                                  onExpansionChanged:
                                                      (val){
                                                    setState((){
                                                      val?cardHeight+=68:cardHeight-=68;
                                                    });
                                                  },
                                                  title:Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                            '阅读数:',
                                                            style: kTextStyle.copyWith(
                                                              color: isDark ? Colors.white : Colors.black,
                                                            ),
                                                          )),
                                                      Text(
                                                        logic.userNumber.browseCount.toString(),
                                                        style: kTextStyle.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20,
                                                          color: isDark
                                                              ? Colors
                                                              .white
                                                              : Colors
                                                              .black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  //备选框
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child:
                                                          SizedBox(),
                                                        ),
                                                        Expanded(
                                                          flex: 4,
                                                          child:
                                                          FittedBox(
                                                            fit: BoxFit
                                                                .fill,
                                                            child: Text(
                                                              'More:',
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child:
                                                          SizedBox(),
                                                        ),
                                                        Expanded(
                                                          flex: 10,
                                                          child:
                                                          GestureDetector(
                                                            onTap:
                                                            (() async {
                                                              isHomeOpen=false;
                                                              indexOfMenu.value =Menu['home']!;
                                                            }),
                                                            child:
                                                            AnimatedContainer(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                  200),
                                                              curve: Curves
                                                                  .easeOutQuint,
                                                              height: 45,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                                border: Border.all(
                                                                    width:
                                                                    1,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(0.8)),
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    20),
                                                              ),
                                                              child:
                                                              Center(
                                                                child:
                                                                Text(
                                                                  '探索',
                                                                  style:
                                                                  TextStyle(
                                                                    color:  textColor,
                                                                    letterSpacing:
                                                                    2.0,
                                                                    fontSize:
                                                                    17,
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child:
                                                          SizedBox(),
                                                        ),
                                                        Expanded(
                                                          flex: 10,
                                                          child:
                                                          GestureDetector(
                                                            onTap:
                                                            (() async {
                                                              createPage("/liulan");
                                                            }),
                                                            child:
                                                            AnimatedContainer(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                  200),
                                                              curve: Curves
                                                                  .easeOutQuint,
                                                              height: 45,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                                border: Border.all(
                                                                    width:
                                                                    1,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(0.8)),
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    20),
                                                              ),
                                                              child:
                                                              Center(
                                                                child:
                                                                AutoSizeText(
                                                                  '历史浏览',
                                                                  maxLines: 1,
                                                                  style:
                                                                  TextStyle(
                                                                    color:  textColor,
                                                                    letterSpacing:
                                                                    2.0,
                                                                    fontSize:
                                                                    17,
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child:
                                                          SizedBox(),
                                                        ),
                                                      ],
                                                    ),
                                                  ],

                                                ),

                                              ),
                                            ),
                                          ),
                                          //收藏数
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: ConcaveDecoration(
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                  lerpDouble(
                                                      0, 100, 0.25)!,
                                                ),
                                              ),
                                              colors: [
                                                shadowColor,
                                                lightShadowColor
                                              ],
                                              depression: 10,
                                            ),
                                            width: screenWidth - 40,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal: 0),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0,
                                                horizontal: 5),
                                            child: Container(
                                              child: Theme(
                                                data: Theme.of(context).copyWith(
                                                    dividerColor:  Colors.transparent
                                                ),
                                                child: ExpansionTile(
                                                  childrenPadding:
                                                  EdgeInsets.only(bottom: 10),
                                                  maintainState: true,
                                                  onExpansionChanged:
                                                      (val){
                                                    setState((){
                                                      val?cardHeight+=68:cardHeight-=68;
                                                    });
                                                  },
                                                  title:Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                            '收藏:',
                                                            style: kTextStyle.copyWith(
                                                              color: isDark ? Colors.white : Colors.black,
                                                            ),
                                                          )),
                                                      Text(
                                                        logic.userNumber.collectCount.toString(),
                                                        style: kTextStyle.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20,
                                                          color: isDark
                                                              ? Colors
                                                              .white
                                                              : Colors
                                                              .black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  //备选框
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child:
                                                          SizedBox(),
                                                        ),
                                                        Expanded(
                                                          flex: 4,
                                                          child:
                                                          FittedBox(
                                                            fit: BoxFit
                                                                .fill,
                                                            child: Text(
                                                              'More:',
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child:
                                                          SizedBox(),
                                                        ),
                                                        Expanded(
                                                          flex: 10,
                                                          child:
                                                          GestureDetector(
                                                            onTap:
                                                            (() async {
                                                              createPage("/shoucang");
                                                            }),
                                                            child:
                                                            AnimatedContainer(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                  200),
                                                              curve: Curves
                                                                  .easeOutQuint,
                                                              height: 45,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                                border: Border.all(
                                                                    width:
                                                                    1,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(0.8)),
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    20),
                                                              ),
                                                              child:
                                                              Center(
                                                                child:
                                                                Text(
                                                                  '我的收藏夹',
                                                                  style:
                                                                  TextStyle(
                                                                    color:  textColor,
                                                                    letterSpacing:
                                                                    2.0,
                                                                    fontSize:
                                                                    17,
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child:
                                                          SizedBox(),
                                                        ),
                                                      ],
                                                    ),
                                                  ],

                                                ),

                                              ),
                                            ),
                                          ),
                                          //关注的主题
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: ConcaveDecoration(
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                  lerpDouble(
                                                      0, 100, 0.25)!,
                                                ),
                                              ),
                                              colors: [
                                                shadowColor,
                                                lightShadowColor
                                              ],
                                              depression: 10,
                                            ),
                                            width: screenWidth - 40,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal: 0),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0,
                                                horizontal: 5),
                                            child: Container(
                                              child: Theme(
                                                data: Theme.of(context).copyWith(
                                                    dividerColor:  Colors.transparent
                                                ),
                                                child: ExpansionTile(
                                                  childrenPadding:
                                                  EdgeInsets.only(bottom: 10),
                                                  maintainState: true,
                                                  onExpansionChanged:
                                                      (val){
                                                    setState((){
                                                      val?cardHeight+=68:cardHeight-=68;
                                                    });
                                                  },
                                                  title:Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                            '喜爱:',
                                                            style: kTextStyle.copyWith(
                                                              color: isDark ? Colors.white : Colors.black,
                                                            ),
                                                          )),
                                                      Text(
                                                        logic.userNumber.favorCount.toString(),
                                                        style: kTextStyle.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20,
                                                          color: isDark
                                                              ? Colors
                                                              .white
                                                              : Colors
                                                              .black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  //备选框
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child:
                                                          SizedBox(),
                                                        ),
                                                        Expanded(
                                                          flex: 4,
                                                          child:
                                                          FittedBox(
                                                            fit: BoxFit
                                                                .fill,
                                                            child: Text(
                                                              'More:',
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child:
                                                          SizedBox(),
                                                        ),
                                                        Expanded(
                                                          flex: 10,
                                                          child:
                                                          GestureDetector(
                                                            onTap:
                                                            (() async {
                                                              newsController logic=Get.find();
                                                              logic.setType("Business");
                                                              isHomeOpen=false;
                                                              indexOfMenu.value=Menu['home']!;
                                                            }),
                                                            child:
                                                            AnimatedContainer(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                  200),
                                                              curve: Curves
                                                                  .easeOutQuint,
                                                              height: 45,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                                border: Border.all(
                                                                    width:
                                                                    1,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(0.8)),
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    20),
                                                              ),
                                                              child:
                                                              Center(
                                                                child:
                                                                Text(
                                                                  '尝试',
                                                                  style:
                                                                  TextStyle(
                                                                    color:  textColor,
                                                                    letterSpacing:
                                                                    2.0,
                                                                    fontSize:
                                                                    17,
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child:
                                                          SizedBox(),
                                                        ),
                                                        Expanded(
                                                          flex: 10,
                                                          child:
                                                          GestureDetector(
                                                            onTap:
                                                            (() async {
                                                              createPage("/xihuan");
                                                            }),
                                                            child:
                                                            AnimatedContainer(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                  200),
                                                              curve: Curves
                                                                  .easeOutQuint,
                                                              height: 45,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                                border: Border.all(
                                                                    width:
                                                                    1,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(0.8)),
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    20),
                                                              ),
                                                              child:
                                                              Center(
                                                                child:
                                                                Text(
                                                                  '历史点赞',
                                                                  style:
                                                                  TextStyle(
                                                                    color:  textColor,
                                                                    letterSpacing:
                                                                    2.0,
                                                                    fontSize:
                                                                    17,
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child:
                                                          SizedBox(),
                                                        ),
                                                      ],
                                                    ),
                                                  ],

                                                ),

                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex:13,
                                                child: SizedBox(),
                                              ),
                                              Expanded(
                                                flex:5,
                                                child: Hero(
                                                  tag: 'rightButton',
                                                  child: NeuButton(
                                                    onPress: (){
                                                      logic.logoutUser();
                                                    },
                                                    ico: Icon(
                                                      Icons.logout,
                                                      size: 30,
                                                      color: textColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                  ),
                                )
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                            ],
                          )
                      ),
                    )
                ),
              ),
            ),
          );
        }
    );
  }
  void createPage(String type) async{
    Loading.show(context);
    data.getNewsIdByUserId(logic.userInfo.id!, type);
    Loading.dismiss(context);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return savedPage(type: type);
      },
    ));

  }

}