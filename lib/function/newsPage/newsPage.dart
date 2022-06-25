import 'dart:async';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:clay_containers/widgets/clay_text.dart';
import 'package:flutter/material.dart';
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
        body: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Row(
              children:
              [
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    '测试'*20,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        height: 1.2,
                        fontFamily: "TitleFont",
                        decorationStyle: TextDecorationStyle.dashed
                    ),

                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ]
            )
          ],
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