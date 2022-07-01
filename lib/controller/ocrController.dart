import 'dart:convert';
import 'dart:io' as IO;
import 'dart:io';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../component/Net/Ocr.dart';
class ocrController extends GetxController{
  late File image;
  String content="";
  Future<String> tobase64() async {
    var value=await IO.File(image.path).readAsBytesSync();
    return base64Encode(value);
  }
  Future<String> getOCR() async {
    await tobase64().then((value) async {
      await ocr(value).then((value){
        if(value!=null)
        content=value;
      });
    });
      return content;
  }
}