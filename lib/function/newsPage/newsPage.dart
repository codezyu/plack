import 'dart:async';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:markdown_widget/markdown_toc.dart';
import 'package:markdown_widget/markdown_widget.dart' as MKWidget;
import 'package:markdown_widget/tags/video.dart';
import 'package:plack/controller/speechController.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../common/constants.dart';
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
  newsController logic=Get.find();
  userInfoController userLogic=Get.find();
  speechController speech=Get.find();

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
    final TocController tocController = TocController();
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            color: Colors.black87,
            onPressed: () => {
              Navigator.of(context).pop('刷新')
            },
            iconSize: 50,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        floatingActionButton: widget.id!=-1?FabCircularMenu(
          fabSize: 100,
          ringDiameter: 200,
          children: [
            IconButton(
                icon: Icon(widget.isLike?Icons.favorite:Icons.favorite_border,color: Colors.redAccent,semanticLabel: '点击为文章点赞',), onPressed: () {
              speech.flutterTts.speak('感谢您的点赞');
                  setState((){widget.isLike=true;});
              logic.setLove(widget.id,userLogic.userInfo.id!);
              Get.snackbar('点赞成功', '感谢您的点赞');
            }),
            IconButton(icon: Icon(widget.isStar?Icons.star:Icons.star_outline,color: Colors.amberAccent,semanticLabel: '点击收藏文章',), onPressed: () {
              speech.flutterTts.speak('感谢您的收藏');
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
                            fontFamily: 'Bold',
                          ),
                        ),
                      ),
                      Markdown(
                        data: widget.type+'\n'+'###### '+'来源:'+widget.author,
                        physics: new NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        styleSheet: MarkdownStyleSheet(
                          p: TextStyle(
                            fontSize: 18,
                            color: Colors.lightBlueAccent,
                          ),
                          h6: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: 'Regular'
                          ),
                        ),
                      ),
                      MKWidget.MarkdownWidget(
                        data: widget.content,
                        padding: const EdgeInsets.all(16.0),
                        physics: new NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        styleConfig: MKWidget.StyleConfig(
                          pConfig:MKWidget.PConfig(
                            textStyle: TextStyle(
                              letterSpacing: 8,
                              fontSize: 22,
                              height: 1.5,
                              fontFamily: 'Medium'
                            )
                          ),
                          videoConfig: VideoConfig(autoInitialize: true),

                        )
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