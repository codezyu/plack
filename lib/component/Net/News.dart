import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/get_core/src/get_main.dart';
import '../../common/config.dart';
import '../../common/constants.dart';
import '../../models/News.dart';
import '../../models/NewsList.dart';
import '../../models/myResponse.dart';

Future<List<News>> getNews(String type,int page) async {
  Map<String,dynamic> params=Map();
  params['page']=page;
  params['pageSize']=3;
  String url=ip+':'+port+categoryNewsUrl+"/"+type;
  Response response = await dio.get(url,queryParameters: params);
  if(response.statusCode!=200){
    Get.snackbar(
      "无法获取新闻内容", // title
      "请检查你的网络连接",
      // message
      icon: Icon(Icons.wifi_off),
      colorText: Colors.black,
      shouldIconPulse: true,
      barBlur: 20,
      isDismissible: true,
      duration: Duration(seconds: 3),
    );
    return List.filled(0,getTemplate());
  }
  else{
    MyResponse myResponse=MyResponse.fromJson(response.data,1);
    NewsList mylist=myResponse.data as NewsList;
    if(mylist.news==null||mylist.news!.length==0){
      return List.filled(0,getTemplate());
    }
    return mylist.news!;
  }
}
Future<void> setLoveInfo(int newsid,int userid) async {
  Map<String,int> params=Map();
  params['newsId']=newsid;
  params['userId']=userid;
  String url=ip+':'+port+loveNewsUrl;
  Response response = await dio.post(url,queryParameters: params);
}
Future<void> setCollectionInfo(int newsid,int userid) async {
  Map<String,int> params=Map();
  params['newsId']=newsid;
  params['userId']=userid;
  String url=ip+':'+port+collectNewsUrl;
  Response response = await dio.post(url,queryParameters: params);
}
Future<void> setVisitInfo(int newsid,int userid) async {
  Map<String,int> params=Map();
  params['newsId']=newsid;
  params['userId']=userid;
  String url=ip+':'+port+visitNewsUrl;
  Response response = await dio.post(url,queryParameters: params);
  print(response);
}
News getTemplate(){
  News news=News(
    newsTitle: "请检查你的网络连接",
    newsType: "无",
    id: 0,
    content: "请检查你的网络连接"
  );
  return news;
}