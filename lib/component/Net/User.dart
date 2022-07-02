import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:plack/component/Net/util.dart';
import 'package:plack/models/Number.dart';
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
Future<bool> updatepassword(String username,String oldpassword,String newpassword) async {
  if(oldpassword.isNotEmpty&&newpassword.isNotEmpty) {
    String url=ip + ':' + port+newpasswordUrl;
    var data={
      "username":username,
      "oldpassword":oldpassword,
      "newpassword":newpassword,
    };
    Response response = await dio.post(url
    , data: data);
    if (response.statusCode == 200) {
      return Future.value(true);
    }
  }
  return Future.value(false);
}
Future<Number> getUserNum(int userid) async {
  var params={
    "userId": userid
  };
  Response response = await dio.get(
      ip + ':' + port+getNum,queryParameters:params);
  print(response.data);
  if (response.statusCode == 200) {
    MyResponse myResponse=MyResponse.fromJson(response.data,Number.fromJson);
    Number number=myResponse.data as Number;
    return number;
  }
  return Number(
    favorCount: 0,
    collectCount: 0,
    browseCount: 0,
  );

}
Future<UserInfo?> getInfo(String token) async {
  if(token==null){
    return null;
  }
  else{
    dio.options.headers["Authorization"]=token;
    Response response = await dio.get(
        ip + ':' + port+userInfoUrl);
    if (response.statusCode == 200) {
      MyResponse myResponse=MyResponse.fromJson(response.data,UserInfo.fromJson);
      UserInfo userInfo=myResponse.data as UserInfo;
      return userInfo;
    }
    else{
      return null;
    }
  }
}