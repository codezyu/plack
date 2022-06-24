import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plack/style/NeuButton.dart';
import 'package:webview_flutter/webview_flutter.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: NeuButton(
        ico: FaIcon(
          FontAwesomeIcons.heart,
          size: 30,
          color: Colors.red,
        )
      ),
    );
  }
}