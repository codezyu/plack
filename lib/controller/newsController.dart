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
  late List<News> news=List.generate(1, (index)=>getTemplate()).obs;
  void getNewsbyCategory(){
   getNews(_type).then((value) {
     news=value;
   });
  }
  void getSpeciedNews(String id){

  }
  void setType(String type){
    print(type);
    _type=type;
    getNewsbyCategory();
    update();
  }
}