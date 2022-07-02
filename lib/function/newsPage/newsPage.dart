import 'dart:async';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../common/constants.dart';
import '../../common/myRadialMenu.dart';
import '../../controller/newsController.dart';
import '../../controller/userInfoController.dart';
//新闻页面
class NewsPage extends StatefulWidget{
  final int id;
  final String title;
  final String author;
  final String type;
  final String content;
  bool isStar=false;
  bool isLike=false;
  NewsPage({required this.id, required this.title, required this.author, required this.type, required this.content});
  @override
  _NewsPageState createState()=> _NewsPageState();
}
class _NewsPageState extends State<NewsPage>{
  //网页加载
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  final logic=Get.put(newsController());
  final userLogic=Get.put(userInfoController());
  @override
  void initState(){
    print(widget.id);
    // print(userLogic.userInfo.id!);
    if(widget.id!=-1)
      logic.setVisit(widget.id, userLogic.userInfo.id!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
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
        floatingActionButton: widget.id!=-1?FabCircularMenu(
          ringDiameter: 150,
          children: [
            IconButton(
                icon: Icon(widget.isLike?Icons.favorite:Icons.favorite_border,color: Colors.redAccent,), onPressed: () {
              setState((){widget.isLike=true;});
              logic.setLove(widget.id,userLogic.userInfo.id!);
              Get.snackbar('点赞成功', '感谢您的点赞');
            }),
            IconButton(icon: Icon(widget.isStar?Icons.star:Icons.star_outline,color: Colors.amberAccent,), onPressed: () {
              setState((){widget.isStar=true;});
              logic.setCollection(widget.id,userLogic.userInfo.id!);
              Get.snackbar('收藏成功', '感谢您的收藏');
            })
          ],
        ):null,
        body: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.fromLTRB(12, 6, 12, 12),
          color: backgroundNewsColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child:ListView(
                    children: <Widget>[
                      Markdown(
                        data: '# '+widget.title,
                        physics: new NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        styleSheet: MarkdownStyleSheet(
                          h1: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'TitleFont',
                          ),
                        ),
                      ),
                      Markdown(
                        data: widget.type+'\n'+'###### '+'来源:'+widget.author,
                        physics: new NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        styleSheet: MarkdownStyleSheet(
                          p: TextStyle(
                            fontSize: 12,
                            color: Colors.lightBlueAccent,
                          ),
                          h6: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Markdown(
                        data: widget.content,
                        physics: new NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        styleSheet: MarkdownStyleSheet(
                          p: TextStyle(
                            fontFamily: 'TitleFont',
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        )
    );
  }
}
class AlmostEndFloatFabLocation extends StandardFabLocation
    with FabEndOffsetX, FabFloatOffsetY {
  @override
  double getOffsetY(ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment){
    final double directionalAdjustment =
    scaffoldGeometry.textDirection == TextDirection.ltr ? -100.0 : 100.0;
    return super.getOffsetY(scaffoldGeometry, adjustment) +
        directionalAdjustment;
  }

}