import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
class dataController extends GetxController{
  late final userBox;
  static const String userInfo='plack_userinfo';
  static const String userToken='plack_userToken';
  static const String userName='plack_userName';
  late final newBox;
  var homeroute=false.obs;
  Future<void> init() async {
    await Hive.initFlutter();
    // Hive.registerAdapter(ContactAdapter());
    await Hive.openBox(userInfo);
  }
  @override
  void onInit(){
    userBox=Hive.box(userInfo);
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