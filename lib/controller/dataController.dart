import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../common/config.dart';
class dataController extends GetxController{
  final userBox=Hive.box(userInfo);
  late final newBox;
  var homeroute=false;
  @override
  void onInit() async{
  }
  @override
  void onReady(){
  }
  String getToken(){
    return userBox.get(userToken);
  }
  void setToken(String token) async {
    await userBox.put(userToken,token);
  }
  String getUserName(){
    return userBox.get(userName);
  }
  Future<void> setUserName(String name) async {
    await userBox.put(userName,name);
  }
  String getUserToken(){
    return getToken();
  }
}