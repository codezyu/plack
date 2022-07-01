import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:plack/component/Net/News.dart';

import '../common/config.dart';
import '../common/constants.dart';
import '../models/News.dart';

class newsController extends GetxController{
  var _type="Business";
  Map<int,String> cate={
    0:'Business'
  };
  Map<String,int> page={
    'Business':1,
    'Entertainment':1,
    'General':1,
    'Health':1,
    'Science':1,
    'Sports':1,
    'Technology':1,
  };
  Map<String,List<News>> newslist={
    'Business':List.filled(1, getTemplate()),
    'Entertainment':List.filled(1, getTemplate()),
    'General':List.filled(1, getTemplate()),
    'Health':List.filled(1, getTemplate()),
    'Science':List.filled(1, getTemplate()),
    'Sports':List.filled(1, getTemplate()),
    'Technology':List.filled(1, getTemplate()),
  };
  late List<News> news=(List.generate(1, (index)=>getTemplate())).obs;
  void getNewsbyCategory(int pageindex){
    getNews(_type,pageindex).then((value) {
      print(value.length);
     if(value.length!=0)
       {
           news=value;
           newslist[_type]=news;
           page[_type]=page[_type]!+1;
       }
     else{
       news=newslist[_type]!;
     }
     print(news.first.newsType);
     update();
   });
  }
  @override
  void onInit(){
    getNewsbyCategory(page[_type]!);
    super.onInit();
  }
  void getSpeciedNews(String id){

  }
  void setType(String type){
    _type=type;
    getNewsbyCategory(page[type]!);
  }
  void setLove(int newsid,int userid){
    setLoveInfo(newsid, userid);
  }
  void setCollection(int newsid,int userid){
    setCollectionInfo(newsid, userid);
  }
  void setVisit(int newsid,int userid){
    setVisitInfo(newsid, userid);
  }
}