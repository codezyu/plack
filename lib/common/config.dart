import 'package:camera/camera.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:plack/common/SharedPref.dart';

const perPixel = 0.0025641025641026;
bool isDrawerOpen = false;
bool isAboutOpen = false;
bool isHomeOpen = true;
bool isSettingsOpen = false;
bool isFavouriteOpen=false;
bool openedAfterDbUpdate = false;
bool isCameraOpen=false;
List<CameraDescription> cameras = [];
DisplayMode? selected;
bool? isContrast = false;

const Map<String, int> Menu = {
  'home':0,
  'favourite':1,
  'camera':2,
  'login':-1,
  'about':3,
  'setting':4,
  'news':5,
};
const version='0.0.4';
late String token;
SharedPref localStore=SharedPref();
String ip='http://47.99.200.3';
String port='8081';
String signupUrl='/users';
String signinUrl='/oauth/token';
String userUpdateUrl='user/update';
String newsid='1';
String newsUrl='news/$newsid';
String categoryNewsUrl="/categorypage";
String userInfoUrl="/self";
String loveNewsUrl="/xihuan";
String collectNewsUrl="/shoucang";
String visitNewsUrl="/liulan";
String ocrUrl="/ocr";
String newpasswordUrl="/user/update";
String getNum="/news/user/summary";
var headers = {"Access-Control-Allow-Origin": "*"};

const String userInfo='plack_userinfo';
const String userToken='plack_userToken';
const String userName='plack_userName';


