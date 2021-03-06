import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plack/controller/newsController.dart';
import 'package:plack/function/homePage/CategoryCard.dart';
import 'package:plack/function/newsPage/newsPage.dart';
import 'package:plack/style/NeuCard.dart';

import '../../common/config.dart';
import '../../common/constants.dart';
import '../../common/providers.dart';
import '../../models/CategoryModel.dart';
import '../../style/NeuButton.dart';
import 'getCategories.dart';

//主页
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState()=> _HomePageState();

}
class _HomePageState extends State<HomePage>{
  newsController logic=Get.find();
  ValueNotifier<String> _titleName = ValueNotifier<String>('新闻');
  late AnimationController playGradientControl;
  bool isBackPressed = false;
  late double screenWidth;
  //缩放系数
  double scaleFactor = 1;
  double xOffset = 0;
  double yOffset = 0;
  double _opacity = 1;
  List<CategoryModel> categories=<CategoryModel>[];
  var scrollController;
  @override
  void initState() {
    super.initState();
    categories=getCategories();
    scrollController = ScrollController();
    BackButtonInterceptor.add(myInterceptor);
    setState(() {
      xOffset = 250;
      yOffset = 140;
      isBackPressed = false;
      scaleFactor = 0.7;
      isDrawerOpen = true;
      isHomeOpen = false;
    });
  }
  @override
  void dispose() {
    // player.dispose();
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (isHomeOpen) {
      setState(() {
        isBackPressed = true;
        xOffset = adjusted(250);
        yOffset = adjusted(140);
        scaleFactor = 0.7;
        isDrawerOpen = true;
        isHomeOpen = false;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
          isHomeOpen ? Brightness.dark : Brightness.light,
          systemNavigationBarColor: isAboutOpen ? backgroundC[0] : drawerColor,
          systemNavigationBarIconBrightness:
          isHomeOpen ? Brightness.dark : Brightness.light,
          systemNavigationBarDividerColor:
          isHomeOpen ? backgroundC[0] : drawerColor,
        ));
      });
      return true;
    }
    else
      return false;
  }
  double adjusted(double val) => val * screenWidth * perPixel;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Consumer(
        builder: (context, ref, child){
          bool isDark = ref.read(isDarkProvider);
          Color backgroundColor = ref.watch(backgroundProvider);
          Color shadowColor = ref.watch(shadowProvider);
          Color lightShadowColor = ref.watch(lightShadowProvider);
          Color textColor = ref.watch(textProvider);
          return ValueListenableBuilder(
              valueListenable: indexOfMenu,
              builder: (context, dynamic val, child){
                if (!isHomeOpen && indexOfMenu.value == Menu['home'] && !isBackPressed) {
                  Future.delayed(Duration(microseconds: 1)).then((value) {
                    setState(() {
                      xOffset = 0;
                      yOffset = 0;
                      scaleFactor = 1;
                      isDrawerOpen = false;
                      isHomeOpen = true;
                    });
                  });
                } else if (indexOfMenu.value != Menu['home']) isBackPressed = false;
                return child!;
              },
              child: AnimatedContainer(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                duration: Duration(milliseconds: drawerAnimDur),
                curve: Curves.easeInOutQuart,
                transform: Matrix4.translationValues(xOffset, yOffset, 100)
                  ..scale(scaleFactor),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                onEnd: (() {
                  if (isHomeOpen && indexOfMenu.value == Menu['home']) {
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness:
                      isHomeOpen ? Brightness.dark : Brightness.light,
                      systemNavigationBarColor:
                      isHomeOpen ? backgroundColor : drawerColor,
                      systemNavigationBarIconBrightness:
                      isHomeOpen ? Brightness.dark : Brightness.light,
                      systemNavigationBarDividerColor:
                      isHomeOpen ? backgroundColor : drawerColor,
                    ));
                  }
                }),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(isHomeOpen ? 0 : 28),
                ),
                child: GestureDetector(
                  onTap: (() {
                    if (!isHomeOpen && indexOfMenu.value == Menu['home']) {
                      setState(() {
                        xOffset = 0;
                        yOffset = 0;
                        scaleFactor = 1;
                        isDrawerOpen = false;
                        isHomeOpen = true;
                      });
                    }
                  }),
                  onHorizontalDragEnd: ((_) {
                    if (!isHomeOpen && indexOfMenu.value == Menu['home']) {
                      setState(() {
                        xOffset = 0;
                        yOffset = 0;
                        scaleFactor = 1;
                        isDrawerOpen = false;
                        isHomeOpen = true;
                      });
                    }
                  }),
                  //淡入淡出效果
                  child:AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      //1为完全可见
                      opacity: _opacity,
                      child: AbsorbPointer(
                          absorbing: !isHomeOpen,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //icon
                              Expanded(
                                flex: 10,
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
                                            semanticsLabel: '新闻',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              letterSpacing: 2.0,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        NeuButton(
                                          ico: Icon(
                                            Icons.menu_rounded,
                                            size: 30,
                                            color: Colors.black87,
                                            semanticLabel: '回到菜单，体验更多功能',
                                          ),
                                          onPress: (() {
                                            setState(() {
                                              FocusScope.of(context).unfocus();
                                              isBackPressed = true;
                                              xOffset = 250;
                                              yOffset = 140;
                                              scaleFactor = 0.7;
                                              isDrawerOpen = true;
                                              isHomeOpen = false;
                                              SystemChrome.setSystemUIOverlayStyle(
                                                  SystemUiOverlayStyle(
                                                    statusBarColor: Colors.transparent,
                                                    // isHomeOpen
                                                    //     ? backgroundColor
                                                    //     : drawerColor,
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
                              Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                              //Categories
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 70,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: categories.length,
                                    itemBuilder: (context,index){
                                      return NeumorphicCard(CategoryCard(imageAssetUrl: categories[index].url, categoryName: categories[index].name));
                                    }
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              //新闻推荐
                              Expanded(
                                  flex: 40,
                                  child: NotificationListener(
                                      child: GetBuilder<newsController>(
                                        builder: (controller){
                                          return AnimatedList(
                                              controller: scrollController,
                                              initialItemCount: logic.news.length,
                                              key:GlobalKey<AnimatedListState>(),
                                              //允许滚动超出边界，但之后内容会反弹回来
                                              physics: BouncingScrollPhysics(),
                                              itemBuilder:
                                                  (BuildContext context, int index, animation) {
                                                return GestureDetector(
                                                  onTap:() async {
                                                    FocusScopeNode currentFocus =
                                                    FocusScope.of(context);
                                                    if (!currentFocus.hasPrimaryFocus) {
                                                      currentFocus.unfocus();
                                                    }
                                                    await Navigator.push(
                                                        context,
                                                        PageRouteBuilder(
                                                            transitionDuration:
                                                            Duration(milliseconds: 250),
                                                            reverseTransitionDuration:
                                                            Duration(milliseconds: 150),
                                                            transitionsBuilder: (BuildContext
                                                            context,
                                                                Animation<double> animation,
                                                                Animation<double> secAnimation,
                                                                Widget child) {
                                                              return FadeTransition(
                                                                opacity: animation,
                                                                child: child,
                                                              );
                                                            },
                                                            pageBuilder: (BuildContext context,
                                                                Animation<double> animation,
                                                                Animation<double>
                                                                secAnimation) {
                                                              return NewsPage(
                                                                id:logic.news[index].id!,
                                                                title: logic.news[index].newsTitle!,
                                                                author: logic.news[index].author==null?"":logic.news[index].author!,
                                                                content: logic.news[index].content!,
                                                                type:  logic.news[index].newsType!,
                                                              );
                                                            }));
                                                  },
                                                  child: AnimatedContainer(
                                                    duration:Duration(milliseconds: 300),
                                                    margin: EdgeInsets.symmetric(
                                                        vertical: 15, horizontal: 20),
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 15, horizontal: 15),
                                                    width: screenWidth,
                                                    height: 200,
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
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          alignment: Alignment.centerLeft,
                                                          child:Text(
                                                            logic.news[index].newsTitle!,
                                                            maxLines: 3,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TitleTextStyle.copyWith(
                                                              color: Colors.black87,
                                                              fontSize: 20,
                                                              fontFamily: 'Medium',
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: SizedBox(),
                                                          flex: 1,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '分类:',
                                                              style: TextStyle(
                                                                color: Colors.lightGreen,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                             logic.news[index].newsType!,
                                                              style: TextStyle(
                                                                fontWeight:FontWeight.bold,
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: SizedBox(),
                                                              flex: 1,
                                                            ),
                                                            Text(
                                                              '推荐',
                                                              style: TextStyle(
                                                                color: Colors.cyan,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );

                                              }
                                          );
                                        },
                                      )
                                  )
                              ),
                            ],
                          )
                      )
                  ),
                ),
              )
          );
        }
    );
  }

}