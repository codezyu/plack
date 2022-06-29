import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plack/common/config.dart';
import 'package:plack/controller/dataController.dart';
import 'package:plack/models/UserInfo.dart';

import '../component/Net/User.dart';

class userInfoController extends GetxController{
  dataController store=Get.find();
  late UserInfo userInfo;
  late String _token="";
  @override
  void onInit(){
    var token=store.getToken();
    if(token==null||token.isEmpty){
      store.homeroute=false;
    }
    else{
      _token=token;
      store.homeroute=true;
      getUserInfo();
    }
  }
  void getUserInfo(){
    getInfo(_token).then((value){
      var temp=value;
      if(temp==null){
        return;
      }else{
        userInfo=temp;
      }
    });
  }
  Future<bool> signIn(String name,String password) async {
    userInfo=UserInfo();
    userInfo.userName=name;
    await signin(name, password).then((value){
      store.setToken(value);
      _token=value;
    });
    if(_token.isNotEmpty){
      print(_token);
      getUserInfo();
      return true;
    }
    else
      return false;
  }
  Future<bool> signUp(String name,String password) async {
    await signup(name, password).then((value) async {
      await signIn(name, password);
    });
    if(_token.isNotEmpty){
      return true;
    }
    else
      return false;
  }
  Future<void> logoutUser() async {
    store.setToken("");
    _token="";
    await Get.deleteAll(force: true); //deleting all controllers
    Phoenix.rebirth(Get.context!); // Restarting app
    Get.reset(); // resetting getx
  }
}