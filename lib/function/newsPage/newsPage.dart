import 'dart:async';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:clay_containers/widgets/clay_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plack/style/NeuCard.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../common/constants.dart';
import '../../common/myRadialMenu.dart';
//新闻页面
class NewsPage extends StatefulWidget{
  final String id;
  NewsPage({required this.id});
  @override
  _NewsPageState createState()=> _NewsPageState();
}
class _NewsPageState extends State<NewsPage>{
  //网页加载
  final Completer<WebViewController> _controller = Completer<WebViewController>();


  @override
  void initState(){
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
        floatingActionButton: ClayContainer(
          emboss: true,
          height: 50,
          width: 50,
          borderRadius: 50,
          child: myRadialMenu(
              centerButtonAlignment: Alignment.center,
              children: [
                RadialButton(
                  icon: Icon(FontAwesomeIcons.heart),
                  buttonColor: Colors.redAccent,
                  onPress: (){},
                ),
                RadialButton(
                  icon: Icon(Icons.star_border),
                  buttonColor: Colors.greenAccent,
                  onPress: (){

                  },
                ),
              ]
          ),
        ),
        floatingActionButtonLocation: AlmostEndFloatFabLocation(),
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
                      data: '# '+'测试'*20,
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
                      data: '政治\n'+'###### '+'来源:'+'央视新闻',
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
                      data: '测试'*200,
                      physics: new NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      styleSheet: MarkdownStyleSheet(
                        p: TextStyle(
                          fontFamily: 'TitleFont',
                          fontSize: 15,
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