import 'package:plack/component/Data/proxy.dart';
//获取存储的token
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