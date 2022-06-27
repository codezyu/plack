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

Future<List<News>> getNews(String type) async {
  Map<String,dynamic> params=Map();
  params['page']=1;
  params['pageSize']=3;
  String url=ip+':'+port+categoryNewsUrl+"/"+type;
  print(url);
  Response response = await dio.get(url,queryParameters: params);
  print(response);
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
    return List.filled(2,getTemplate());
  }
  else{
    MyResponse myResponse=MyResponse.fromJson(response.data,1);
    NewsList mylist=myResponse.data as NewsList;
    if(mylist.size==0){
      return List.filled(2,getTemplate());
    }
    return mylist.news!;
  }

}
News getTemplate(){
  News news=News(
    newsTitle: "请检查你的网络连接",
    newsType: "无",
  );
  return news;
}