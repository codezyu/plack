import 'dart:convert';
import 'dart:io' as IO;
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plack/function/MachineLearning/ink/digitalInk.dart';
import 'package:plack/function/MachineLearning/label/labelImage.dart';
import 'package:plack/function/MachineLearning/language/translate.dart';
import 'package:plack/function/MachineLearning/object/objectDetector.dart';
import 'package:plack/function/MachineLearning/text/textRecognisze.dart';

import '../component/Loading.dart';
import '../component/Net/Ocr.dart';
import '../function/MachineLearning/barcode/barcodeScanner.dart';
import '../function/cameraPage/shared/consts.dart';
import '../function/cameraPage/shared/mode.dart';
import '../function/newsPage/newsPage.dart';
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
  ModeItemModel? _selectedMode;
  static const margin = EdgeInsets.only(
    left: GLOBAL_EDGE_MARGIN_VALUE,
  );
  @override
  void onInit(){
    _selectedMode=begin;
  }
  ModeItemModel? get selectedMode => _selectedMode;
  ModeItemModel begin=ModeItemModel(
    name: '初始化',
    color: Colors.grey,
    introduction: '点选下方使用Plack',
  );
  static double width=50;
  Map<String,Icon> myIcon={
    '高精度拍照文字识别':Icon(Icons.cloud_download_outlined,size:width,color: Color.fromRGBO(61, 111, 252, 1),),
    '高精度图片文字识别':Icon(Icons.wb_cloudy_outlined,size: width, color: Color.fromRGBO(50, 197, 253, 1),),
    'Fast':Icon(Icons.phone_android,size: width,color: Color.fromRGBO(253, 133, 53, 1),),
    '初始化':Icon(Icons.android,size: width,color: Colors.green),
    '文字识别':Icon(Icons.camera_alt_outlined,size: width,color: Color.fromRGBO(255, 179, 120, 1),),
    'LocalImageOCR':Icon(Icons.camera_alt_outlined,size: width,color: Color.fromRGBO(224, 204, 151, 1),),
    '文本翻译': Icon(color:Color.fromRGBO(255, 192, 0, 1),Icons.translate_outlined,size: width,),
    '物体分类': Icon(color:Color(0xffeec9d2),Icons.question_mark,size: width,),
    '不懂找我': Icon(color:Color(0xff2a4d69),Icons.emoji_objects_outlined,size: width,),
    '条形码扫描':Icon(color:Color(0xffd0e1f9),FontAwesomeIcons.barcode,size: width,),
    '手写文字识别':Icon(color: Color.fromRGBO(253, 133, 53, 1),Icons.back_hand_outlined,size: width,),
    'Plack实验室':Icon(color: Color(0xffff6f69),Icons.music_note_outlined,size: width,)
  };
  Icon getIcon(){
    return myIcon[selectedMode!.name]!;
  }
  List<ModeItemModel> nodes = const [
    ModeItemModel(
      name: '不懂找我',
      color: Color(0xff2a4d69),
      introduction: '自动分割并且识别分类',
    ),
    ModeItemModel(
      name: '物体分类',
      color: Color(0xffeec9d2),
      introduction: '拍照识别物体类别',
    ),
    // ModeItemModel(
    //   name: '手写文字识别',
    //   color: Color.fromRGBO(253, 133, 53, 1),
    //   introduction: '进行手写文字识别',
    // ),
    ModeItemModel(
      name: '文字识别',
      color: Color.fromRGBO(255, 179, 120, 1),
      introduction: '进行文字识别',
    ),
    ModeItemModel(
      name: '高精度拍照文字识别',
      color: Color.fromRGBO(61, 111, 252, 1),
      introduction: '使用相机进行更高精度文字识别',
    ),
    ModeItemModel(
      name: '高精度图片文字识别',
      color: Color.fromRGBO(50, 197, 253, 1),
      introduction: '选取图片进行更高精度文字识别',
    ),
    ModeItemModel(
      name: '文本翻译',
      color: Color.fromRGBO(255, 192, 0, 1),
      introduction: '自动识别语言进行简单翻译',
    ),
    ModeItemModel(
      name: '条形码扫描',
      color: Color(0xffd0e1f9),
      introduction: '自动定位扫描',
    ),
    ModeItemModel(
      name: 'Plack实验室',
      color: Color(0xffff6f69),
      introduction: '敬请关注,更多功能还在路上...',
    ),
  ];
  selectMode(ModeItemModel mode,BuildContext context) {
    _selectedMode = mode;
    update();
    myhandle(mode.name, context);
  }
  Future<void> myhandle(String name,BuildContext context) async {
    if(name=="高精度拍照文字识别"){
      pickCamera();
      createPage(context);
    }
    else if(name=="高精度图片文字识别"){
        pickImage();
        createPage(context);
      }
    else if(name=="文字识别"){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>TextRecognizerView()));
    }
    else if(name=="物体分类"){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageLabelView()));
    }
    else if(name=="不懂找我"){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ObjectDetectorView()));
    }
    else if(name=="条形码扫描"){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BarcodeScannerView()));
    }
    else if(name=="手写文字识别"){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>DigitalInkView()));
    }
    else if(name=='文本翻译'){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LanguageTranslatorView()));
    }
  }
  Future pickImage() async{
    try{
      final image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image1 == null) return;
      image=File(image1.path);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }
  Future pickCamera() async{
    try{
      final image1 = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image1 == null) return;
      image=File(image1.path);
    } on PlatformException catch(e) {
      print('Failed to pick camera: $e');
    }
  }
  void createPage(BuildContext context) {
    Loading.show(context);
    getOCR().then((value) {
      Loading.dismiss(context);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return NewsPage(id: -1,
              title: 'OCR识别结果',
              author: 'plack',
              type: 'ocr',
              content: value);
        },
      ));
    });
  }
}