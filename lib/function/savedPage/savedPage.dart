import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plack/common/constants.dart';
import 'package:plack/controller/newsController.dart';
import 'package:plack/controller/userInfoController.dart';
import 'package:plack/function/newsPage/newsPage.dart';
import '../../common/providers.dart';
import '../../models/News.dart';

class savedPage extends ConsumerStatefulWidget {
  final String type;
  savedPage({required this.type});
  @override
  _savedPageState createState() => _savedPageState();

}
class _savedPageState extends ConsumerState<savedPage> {
  userInfoController data=Get.find();
  newsController logic=Get.find();
  Map<String,String> conv={
    '/xihuan':'喜欢的新闻',
    '/shoucang':'收藏的新闻',
    '/liulan':'浏览的新闻',
};
  @override
  void init(){
    print(data.userInfo.id);
    logic.getNewsIdByUserId(data.userInfo.id!, widget.type);
  }
  @override
  Widget build(BuildContext context) {
    print(data.userInfo.id);
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
          //标题
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  conv[widget.type]!,
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
              child: AnimatedList(
                initialItemCount:logic.userNewsList[widget.type]!.length,
                key:GlobalKey<AnimatedListState>(),
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context,int index,animation)
                  {
                    return FutureBuilder(
                        future: logic.getSpeciedNews(logic.userNewsList[widget.type]![index]),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              // 请求失败，显示错误
                              return Text("Error: ${snapshot.error}");
                            } else {
                              News news=snapshot.data;
                              // 请求成功，显示数据
                              return GestureDetector(
                                onTap: ()async{
                                  FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return NewsPage(id: news.id!, title: news.newsTitle!, author: news.author!, type: news.newsType!, content: news.content!);
                                  },
                                  ));
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
                                            news.newsTitle!,
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
                                        '作者:'+news.author!,
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
                                                news.newsType!,
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
                          }else {
                            // 请求未结束，显示loading
                            return CircularProgressIndicator();
                          }
                        }
                    );
                  }
              )
          ),
        ],
      ),

    );
  }

}