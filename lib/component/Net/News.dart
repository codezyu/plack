import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/get_core/src/get_main.dart';
import 'package:plack/models/NewsConnectList.dart';

import '../../common/config.dart';
import '../../common/constants.dart';
import '../../models/News.dart';
import '../../models/NewsList.dart';
import '../../models/myResponse.dart';

Future<List<News>> getNews(String type,int page) async {
  Map<String,dynamic> params=Map();
  params['page']=page;
  params['pageSize']=2;
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
    MyResponse myResponse=MyResponse.fromJson(response.data,NewsList.fromJson);
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
}
Future<List<int>> getNewsConnects(String type,int userId) async {
  var param={
    "userId":userId
  };
  String url=ip+':'+port+type;
  Response response=await dio.get(url,queryParameters: param);
  MyResponse myResponse=MyResponse.fromJson(response.data,NewsConnectList.fromJson);
  NewsConnectList mylist=myResponse.data as NewsConnectList;
  if(mylist.newsConnect!=null)
    return List.generate(mylist.newsConnect!.length, (index) => mylist.newsConnect![index].newsId!);
  else
    return List.generate(0, (index) => 0);
}
Future<News> getNewByid(int id) async {
  String url=ip+':'+port+getSingleNews+id.toString();
  Response response = await dio.get(url);
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
    return getTemplate();
  }
  else{
    MyResponse myResponse=MyResponse.fromJson(response.data,News.fromJson);
    News news=myResponse.data as News;
    if(news!=null){
      return news;
    }
    return getTemplate();
  }
}
News getTemplate(){
  News news=News(
    newsTitle: "请检查你的网络连接",
    newsType: "无",
    id: -1,
    content: "请检查你的网络连接"
  );
  return news;
}