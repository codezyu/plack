import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:plack/component/Net/util.dart';
import '../../common/config.dart';
import '../../common/constants.dart';
import '../../models/UserInfo.dart';
import '../../models/UserVo.dart';
import '../../models/myResponse.dart';

Future<bool> signup(String username,String password) async {
  if(username.isNotEmpty&&password.isNotEmpty) {
    var vo=UserVo();
    vo.userName=username;
    vo.password=password;
    Response response = await dio.post(
        ip + ':' + port+signupUrl, data: vo.toJson());
    if (response.statusCode == 200) {
      print(response);
      return Future.value(true);
    }
  }
  return Future.value(false);
}
Future<String> signin(String username,String password) async{
  if(username.isNotEmpty&&password.isNotEmpty) {
    var vo=UserVo();
    vo.userName=username;
    vo.password=password;
    Response response = await dio.post(
        ip + ':' + port+signinUrl, data: vo.toJson());
    if (response.statusCode == 200) {
      var data= jsonDecode(response.toString());//3
      if(JudgeState(data['errno'])){
        return Future.value(data['data']);
      }
    }
  }
  return Future.value(null);
}
Future<UserInfo?> getInfo(String token) async {
  if(token==null){
    return null;
  }
  else{
    dio.options.headers["Authorization"]="mawang";
    Response response = await dio.get(
        ip + ':' + port+userInfoUrl);
    if (response.statusCode == 200) {
      MyResponse myResponse=MyResponse.fromJson(response.data,UserInfo.fromJson);
      UserInfo userInfo=myResponse.data as UserInfo;
      print(userInfo);
      return userInfo;
    }
    else{
      return null;
    }
  }
}