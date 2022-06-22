import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/config.dart';
import '../../common/constants.dart';
import '../../common/providers.dart';
import '../../style/NeuButton.dart';

class FavoritePage extends StatefulWidget{
  @override
  _FavoritePageState createState()=>_FavoritePageState();

}
class _FavoritePageState extends State<FavoritePage>{
  ValueNotifier<String> _titleName = ValueNotifier<String>('Favourite');
  late AnimationController playGradientControl;
  late Animation<Color?> colAnim1, colAnim2;
  TextEditingController dialogController = TextEditingController();
  double _opacity = 1;
  late double screenWidth;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isBackPressed = false;
  List<String>? savedList = [];
  @override
  void initState() {
    super.initState();
    isFavouriteOpen=true;
  }
  @override
  Widget build(BuildContext context) {
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
                    playGradientControl.reverse();
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
                                              isHomeOpen = false;
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
                                flex: 0,
                                child: SizedBox(),
                              ),
                              //阅读数
                              Expanded(
                                flex: 6,
                                child: Column(
                                  children: [
                                    Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Reading / Num',
                                          style: kTextStyle.copyWith(
                                            color: isDark ? Colors.white : Colors.black,
                                          ),
                                        )),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              child: Text(
                                                '130',
                                                style: kTextStyle.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                  color: textColor,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //收藏数
                              Expanded(
                                flex: 6,
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Collection',
                                        style: kTextStyle.copyWith(
                                          color: isDark ? Colors.white : Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Text(
                                              '250',
                                              style: kTextStyle.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: textColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //喜欢的主题
                              Expanded(
                                flex: 6,
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Topic',
                                        style: kTextStyle.copyWith(
                                          color: isDark ? Colors.white : Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Text(
                                              '250',
                                              style: kTextStyle.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: textColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //左右按钮
                              Expanded(
                                flex: 5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Hero(
                                      tag: 'leftButton',
                                      child: NeuButton(
                                        ico: Icon(
                                          Icons.bookmark_border_rounded,
                                          size: 30,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                    Hero(
                                      tag: 'rightButton',
                                      child: NeuButton(
                                        ico: Icon(
                                          Icons.save_outlined,
                                          size: 30,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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

}