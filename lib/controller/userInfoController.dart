import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plack/common/config.dart';
import 'package:plack/controller/dataController.dart';
import 'package:plack/models/UserInfo.dart';

import '../component/Net/User.dart';

class userInfoController extends GetxController{
  final store=Get.put(dataController());
  late UserInfo userInfo;
  late String _token="";
  @override
  void onInit(){
    _token=store.getToken();
    print(_token);
    getUserInfo();
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
  bool signIn(String name,String password){
    userInfo=UserInfo();
    userInfo.userName=name;
    signin(name, password).then((value){
      store.setToken(value);
      _token=token;
    });
    if(_token.isNotEmpty){
      return true;
    }
    else
      return false;
  }
  bool signUp(String name,String password){
    bool temp=false;
    signup(name, password).then((value){
      temp=signIn(name, password);
    });
    return temp;
  }
  Future<void> logoutUser() async {
    store.setToken("");
    _token="";
    await Get.deleteAll(force: true); //deleting all controllers
    Phoenix.rebirth(Get.context!); // Restarting app
    Get.reset(); // resetting getx
  }
}