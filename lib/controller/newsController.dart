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
  late List<News> news=(List.generate(1, (index)=>getTemplate()));
  var change=true.obs;
  void getNewsbyCategory(int page){
    print(news.first.newsTitle);
   getNews(_type,page).then((value) {
     if(value.length!=0)
       news=value;
   });
  }
  @override
  void onInit(){
    getNewsbyCategory(page[_type]!);
    ever(change, (callback)=> update());
    print("ok");
    super.onInit();
  }
  void getSpeciedNews(String id){

  }
  void setType(String type){
    _type=type;
    change=(!change.value).obs;
    print(page[type]);
    getNewsbyCategory(page[type]!);
    page[type]=page[type]!+1;
    update();
  }
}