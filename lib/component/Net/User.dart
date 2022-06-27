import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:plack/component/Data/GetData.dart';
import 'package:plack/component/Net/util.dart';
import 'package:plack/models/index.dart';

import '../../common/config.dart';
import '../../common/constants.dart';

Future<bool> signup(String username,String password) async {
  if(username.isNotEmpty&&password.isNotEmpty) {
    Response response = await dio.post(
        ip + ':' + port+signupUrl, data: {"username": username, "password": password});
    if (response.statusCode == 200) {
      return Future.value(true);
    }
  }
  return Future.value(false);
}
Future<bool> signin(String username,String password) async{
  if(username.isNotEmpty&&password.isNotEmpty) {
    var vo=UserVo();
    vo.userName=username;
    vo.password=password;
    Response response = await dio.post(
        ip + ':' + port+signinUrl, data: vo.toJson());
    if (response.statusCode == 200) {
      print(response);
      var data= jsonDecode(response.toString());//3
      if(JudgeState(data['errno'])){
        setToken(data['data']);
        return Future.value(true);
      }
    }
  }
  return Future.value(false);
}