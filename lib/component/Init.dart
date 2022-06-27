import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:plack/common/config.dart';
import 'package:plack/component/Data/proxy.dart';
import '../common/constants.dart';
import 'Config/UserConfig.dart';

Future<void> init() async {
  //初始化数据库
  await Hive.initFlutter();
  // Hive.registerAdapter(ContactAdapter());
  await Hive.openBox(userInfo);
  userBox=Hive.box(userInfo);
  BaseOptions options = BaseOptions(
  );
  token=getUserToken();
  if(token.isNotEmpty){
    homeroute=true;
  }
}