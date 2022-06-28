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
              margin: EdgeInsets.fromLTRB(10, 65, 10, 5),
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
          Expanded(
              child:FutureBuilder(
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
                {
                  if(false){
                    return Center(child: Text('Loading'));
                  }else{
                    return snapshot.data!.length == 0
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: FaIcon(
                                FontAwesomeIcons.puzzlePiece,
                                size: 100,
                                color: Colors.amberAccent,
                              )),
                          SizedBox(
                            height: 40,
                          ),
                          Center(
                              child: Text(
                                '你还没有收藏',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: textColor,
                                ),
                              )),
                          Center(
                              child: Text(
                                '快快点击你喜欢的新闻吧',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: textColor,
                                ),
                              )),
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
                                  height: 140,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                        EdgeInsets.only(left: 10),
                                        child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text(
                                            'test',
                                            style: kTextStyle.copyWith(
                                              color: backgroundColor,
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 26.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceEvenly,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(
                                                  'Time',
                                                  style: kTextStyle
                                                      .copyWith(
                                                    color:
                                                    backgroundColor,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(
                                                  'test',
                                                  style: kTextStyle
                                                      .copyWith(
                                                    color:
                                                    backgroundColor,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 45,
                                            width: 1.3,
                                            color: backgroundColor,
                                          ),
                                          Column(
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(
                                                  'Break',
                                                  style: kTextStyle
                                                      .copyWith(
                                                    color:
                                                    backgroundColor,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(
                                                  '11',
                                                  style: kTextStyle
                                                      .copyWith(
                                                    color:
                                                    backgroundColor,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 45,
                                            width: 1.3,
                                            color: backgroundColor,
                                          ),
                                          Column(
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(
                                                  'Sets',
                                                  style: kTextStyle
                                                      .copyWith(
                                                    color:
                                                    backgroundColor,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(
                                                  '345',
                                                  style: kTextStyle
                                                      .copyWith(
                                                    color:
                                                    backgroundColor,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
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