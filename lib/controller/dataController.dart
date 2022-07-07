import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../common/config.dart';
class dataController extends GetxController{
  final userBox=Hive.box(userInfo);
  final faceBox=Hive.box<List>("faceinfo");
  late final newBox;
  var homeroute=false;
  @override
  void onInit() async{
  }
  @override
  void onReady(){
  }
  String getToken(){
    String? s=userBox.get(userToken);
    if(s==null)
      return "";
    else
      return s;
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
  String getPassword(){
    return userBox.get(userPassword);
  }
  Future<void> setPassword(String name) async {
    await userBox.put(userPassword,name);
  }
  String getUserToken(){
    return getToken();
  }
  void setFace(List<double> data)async{
    print("kkkkk");
    print(data.runtimeType);
    await faceBox.put(userFace,data);
    print(getFace());
  }
  List? getFace(){
   return faceBox.get(userFace);
  }
  void setContrast(bool data)async{
    await userBox.put(userContrast, data);
  }
  Future<bool?> getContrast()async{
    await userBox.get(userContrast);
  }
}