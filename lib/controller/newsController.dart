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
    'Entertainment':1
  };
  Map<String,List<News>> newslist={
    'Business':List.generate(1, (index)=>getTemplate()),
    'Entertainment':List.generate(1, (index)=>getTemplate()),
  };
  late List<News> news=(List.generate(1, (index)=>getTemplate())).obs;
  void getNewsbyCategory(int pageindex){
    getNews(_type,pageindex).then((value) {
     if(value.length!=0)
       {
           news=value;
           newslist[_type]=news;
           page[_type]=page[_type]!+1;
       }
     else{
       news=newslist[_type]!;
     }
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
}