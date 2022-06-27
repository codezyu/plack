import 'package:plack/common/config.dart';
import 'package:plack/component/Data/GetData.dart';


void resetToken(String newtoken){
  token=newtoken;
  setToken(newtoken);
}
String getUserToken(){
  return getToken();
}