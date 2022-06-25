import 'package:dio/dio.dart';

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
    Response response = await dio.post(
        ip + ':' + port+signinUrl, data: {"username": username, "password": password});
    if (response.statusCode == 200) {
      response.data.toString();
      return Future.value(true);
    }
  }
  return Future.value(false);
}