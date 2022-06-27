import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:plack/component/Net/News.dart';
import 'package:plack/models/news.dart';

import '../common/config.dart';
import '../common/constants.dart';

class newsController extends GetxController{
  var _type="Business";
  Map<int,String> cate={
    0:'Business'
  };
  late List<News> news;
  List<News> getNewsbyCategory(){
   late List<News> temp;
   getNews(_type).then((value) {
     temp=value;
   });
    return temp;
  }
  void getSpeciedNews(String id){

  }
  void setType(String type){
    _type=type;
    news=getNewsbyCategory();
    update();
  }
}