import 'package:camera/camera.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

const perPixel = 0.0025641025641026;
bool isDrawerOpen = false;
bool isAboutOpen = false;
bool isHomeOpen = false;
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
const version='1.0.0';
late String token;
String ip='http://36.133.76.148';
String port='23221';
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
String getSingleNews="/news/";
var headers = {"Access-Control-Allow-Origin": "*"};

const String userInfo='plack_userinfo';
const String userToken='plack_userToken';
const String userName='plack_userName';
const String userPassword='plack_password';
const String userFace='plack_userFace';
const String userContrast='plack_setting';

