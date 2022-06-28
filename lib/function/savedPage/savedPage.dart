import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plack/common/constants.dart';
import 'package:plack/controller/userInfoController.dart';
import '../../common/providers.dart';

class savedPage extends ConsumerStatefulWidget {
  @override
  _savedPageState createState() => _savedPageState();

}
class _savedPageState extends ConsumerState<savedPage> {
  final logic=Get.put(userInfoController());
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = ref.watch(backgroundProvider);
    Color shadowColor = ref.watch(shadowProvider);
    Color lightShadowColor = ref.watch(lightShadowProvider);
    Color textColor = ref.watch(textProvider);
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          color: Colors.black54,
          onPressed: () => {
            Navigator.of(context).pop('刷新')
          },
          iconSize: 30,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 25, 10, 5),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  '我的收藏',
                  style: TitleTextStyle.copyWith(
                    color: textColor,
                    letterSpacing: 2.0,
                    fontSize: 31,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              color: backgroundColor,
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child:FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
              {
                if(false){
                  return Center(child: Text('Loading'));
                }else{
                  return false
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: SizedBox(height: 10,)),
                        Center(
                            child: FaIcon(
                              FontAwesomeIcons.android,
                              size: 100,
                              color: Colors.amberAccent,
                            )),
                        SizedBox(height: 5,),
                        Center(
                            child: Text(
                              'Ops!你还没有收藏',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.greenAccent,
                              ),
                            )),
                        SizedBox(height: 10,),
                        Center(
                            child: Text(
                              '快快点击你喜欢的新闻吧',
                              style: TextStyle(
                                fontSize: 20,
                                color: textColor,
                              ),
                            )),
                        Expanded(
                          flex:2,
                          child: SizedBox(
                            height: 20,
                          ),),
                      ],
                    ),
                  )
                      :GetBuilder<userInfoController>(
                    builder: (controller){
                      return AnimatedList(
                          initialItemCount:5,
                          key:GlobalKey<AnimatedListState>(),
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context,int index,animation){
                            return GestureDetector(
                              onTap: ()async{
                                FocusScopeNode currentFocus =
                                FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 25),
                                height: 230,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(height: 10,),
                                        Text(
                                          textAlign: TextAlign.left,
                                          '当我放牛的时候我在想什么奇奇怪怪给的点点滴滴得到适当的',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: kTextStyle
                                              .copyWith(
                                            color:
                                            backgroundColor,
                                            fontSize: 25,
                                            wordSpacing: 5,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Expanded(child: Text(
                                      textAlign: TextAlign.right,
                                      '作者:马超',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: kTextStyle
                                          .copyWith(
                                        color:
                                        backgroundColor,
                                        fontWeight:
                                        FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),),
                                    Row(
                                      children: [
                                        Expanded(child: SizedBox(width: 1,)),
                                        Container(
                                          margin:
                                          EdgeInsets.only(left: 10),
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '商业',
                                              style: kTextStyle.copyWith(
                                                color: backgroundColor,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: gradientList[index % 5],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight),
                                  borderRadius:
                                  BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                        color: gradientList[index % 5]
                                        [1]
                                            .withOpacity(0.22),
                                        offset: Offset(8, 6),
                                        blurRadius: 15),
                                    BoxShadow(
                                        color: gradientList[index % 5]
                                        [0]
                                            .withOpacity(0.22),
                                        offset: Offset(-8, -6),
                                        blurRadius: 15),
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    },

                  );
                }
              },
            ),
          ),
        ],
      ),

    );
  }

}