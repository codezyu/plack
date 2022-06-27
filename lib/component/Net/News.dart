import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/config.dart';
import '../../common/constants.dart';
import '../../models/news.dart';

Future<List<News>> getNews(String type) async {
  Map<String,dynamic> params=Map();
  params['page']=1;
  params['pageSize']=3;
  String url=ip+':'+port+categoryNewsUrl+"/"+type;
  Response response = (await dio.get(url,queryParameters: params)) as Response;
  if(!response.isOk){
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
  return List.filled(2,getTemplate());

}
News getTemplate(){
  News news=News();
  news.name="请检查你的网络连接";
  news.topic="无";
  return news;
}