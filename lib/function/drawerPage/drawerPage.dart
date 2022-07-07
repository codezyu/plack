import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/config.dart';
import '../../common/constants.dart';
//侧边栏
class drawerPage extends StatefulWidget {

  @override
  _drawerPageState createState() => _drawerPageState();
}

class _drawerPageState extends State<drawerPage> {
  late double screenWidth;

  double adjusted(double val) => val * screenWidth * perPixel;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    //异形屏需要safearea
    return SafeArea(
      //填充，留白
        child: Padding(
          //指定四个方向的填充
          padding: const EdgeInsets.fromLTRB(20, 25, 0, 5),
          //根据选项局部刷新
          child: ValueListenableBuilder(
            valueListenable: indexOfMenu,
            builder: (BuildContext context, value, Widget? child) {
              return Column(
                  //空白间隔排布
                  //主轴
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //交叉轴
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Plack',
                          style: TextStyle(
                            color: Colors.orange[100],
                            letterSpacing: 2.0,
                            fontSize: 30,
                            fontFamily: 'MontserratBold',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Connect the World',
                          style: TextStyle(
                            color: Colors.orangeAccent[200],
                            letterSpacing: 1.5,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    //带动画的容器
                    AnimatedContainer(
                      width: 170,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 9 / 20,
                      //时间
                      duration: Duration(milliseconds: 250),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //手势监测
                          //新闻
                          GestureDetector(
                            //发送通知
                            onTap: (() {
                              setState(() {
                                indexOfMenu.value = Menu['home']!;
                              });
                            }),
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.fiber_new_sharp,
                                    size: 25,
                                    color: Colors
                                        .teal[indexOfMenu.value == 0
                                        ? 200
                                        : 500],
                                  ),
                                  SizedBox(width: screenWidth / 20),
                                  Text(
                                    '新闻',
                                    semanticsLabel: '查看新闻，和世界沟通',
                                    style: TextStyle(
                                      fontFamily: 'MontserratBold',
                                      color: indexOfMenu.value == Menu['home']! ? Colors.blue[500] : Colors.white70,
                                      letterSpacing: 1.5,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 4 / 85,
                          ),
                          GestureDetector(
                            //发送通知
                            onTap: (() {
                              setState(() {
                                indexOfMenu.value = Menu['favourite']!;
                              });
                            }),
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.face,
                                    size: 25,
                                    color: Colors
                                        .teal[indexOfMenu.value == 0
                                        ? 200
                                        : 500],
                                  ),
                                  SizedBox(width: screenWidth / 20),
                                  Text(
                                    '主页',
                                    semanticsLabel: '查看我的足迹',
                                    style: TextStyle(
                                      fontFamily: 'MontserratBold',
                                      color: indexOfMenu.value == Menu['favourite']! ? Colors.yellow[200] : Colors.white70,
                                      letterSpacing: 1.5,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 4 / 85,
                          ),
                          GestureDetector(
                            //发送通知
                            onTap: (() {
                              setState(() {
                                indexOfMenu.value = Menu['camera']!;
                              });
                            }),
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    size: 25,
                                    color: Colors
                                        .teal[indexOfMenu.value == 0
                                        ? 200
                                        : 500],
                                  ),
                                  SizedBox(width: screenWidth / 20),
                                  Text(
                                    '辅助功能',
                                    semanticsLabel: '使用plack辅助功能',
                                    style: TextStyle(
                                      fontFamily: 'MontserratBold',
                                      color:indexOfMenu.value == Menu['camera']! ? Colors.greenAccent[200] : Colors.white70,
                                      letterSpacing: 1.5,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 4 / 85,
                          ),
                          GestureDetector(
                            onTap: (() {
                              setState(() {
                                indexOfMenu.value = Menu['about']!;
                              });
                            }),
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.account_balance_outlined,
                                    size: 25,
                                    color: Colors
                                        .teal[indexOfMenu.value == 0
                                        ? 200
                                        : 500],
                                  ),
                                  SizedBox(width: screenWidth / 20),
                                  Text(
                                    '关于',
                                    semanticsLabel: '我们和你在一起',
                                    style: TextStyle(
                                      fontFamily: 'MontserratBold',
                                      color: indexOfMenu.value == Menu['about']! ? Colors.deepPurpleAccent[200] : Colors.white70,
                                      letterSpacing: 1.5,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 4 / 85,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (() {
                        setState(() {
                          indexOfMenu.value = 4;
                        });
                      }),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.settings,
                                size: 23,
                                color: Colors
                                    .teal[indexOfMenu.value == 4 ? 200 : 500],
                              ),
                              SizedBox(
                                width: screenWidth / 40,
                              ),
                              Text(
                                '设置',
                                style: TextStyle(
                                  fontFamily: 'MontserratBold',
                                  color: Colors
                                      .teal[indexOfMenu.value == 4 ? 200 : 500],
                                  letterSpacing: 1.5,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: screenWidth / 20,
                              ),
                              Container(
                                height: 20,
                                width: 2.5,
                                color: Colors.teal,
                              ),
                              SizedBox(
                                width: screenWidth / 20,
                              ),
                              GestureDetector(
                                onTap: (() {
                                  SystemChannels.platform
                                      .invokeMethod('SystemNavigator.pop');
                                }),
                                child: Text(
                                  '退出',
                                  style: TextStyle(
                                    fontFamily: 'MontserratBold',
                                    color: Colors.teal,
                                    letterSpacing: 1.5,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ]
              );
            },),
        )
    );
  }
}