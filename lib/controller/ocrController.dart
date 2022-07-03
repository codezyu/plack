import 'dart:convert';
import 'dart:io' as IO;
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plack/function/MachineLearning/label/labelImage.dart';

import '../component/Loading.dart';
import '../component/Net/Ocr.dart';
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
    introduction: '测试',
  );
  static double width=50;
  Map<String,Icon> myIcon={
    'CameraOCR':Icon(Icons.cloud_download_outlined,size:width,color: Color.fromRGBO(61, 111, 252, 1),),
    'ImageOCR':Icon(Icons.wb_cloudy_outlined,size: width, color: Color.fromRGBO(50, 197, 253, 1),),
    'Fast':Icon(Icons.phone_android,size: width,color: Color.fromRGBO(253, 133, 53, 1),),
    '初始化':Icon(Icons.android,size: width,color: Colors.green),
    'LocalCameraOCR':Icon(Icons.camera_alt_outlined,size: width,color: Color.fromRGBO(255, 179, 120, 1),),
    'LocalImageOCR':Icon(Icons.camera_alt_outlined,size: width,color: Color.fromRGBO(224, 204, 151, 1),),
    '文本翻译': Icon(color:Color.fromRGBO(255, 192, 0, 1),Icons.translate_outlined,size: width,),
    '不懂问我': Icon(color:Color(0xffeec9d2),Icons.translate_outlined,size: width,),
  };
  Icon getIcon(){
    return myIcon[selectedMode!.name]!;
  }
  List<ModeItemModel> nodes = const [
    ModeItemModel(
      name: 'LocalCameraOCR',
      color: Color.fromRGBO(255, 179, 120, 1),
      introduction: '使用相机拍摄进行文字识别',
    ),
    ModeItemModel(
      name: 'LocalImageOCR',
      color: Color.fromRGBO(224, 204, 151, 1),
      introduction: '选取图片进行文字识别',
    ),
    ModeItemModel(
      name: 'CameraOCR',
      color: Color.fromRGBO(61, 111, 252, 1),
      introduction: '使用相机进行更高精度文字识别',
    ),
    ModeItemModel(
      name: 'ImageOCR',
      color: Color.fromRGBO(50, 197, 253, 1),
      introduction: '选取图片进行更高精度文字识别',
    ),
    ModeItemModel(
      name: '文本翻译',
      color: Color.fromRGBO(255, 192, 0, 1),
      introduction: '自动识别语言进行简单翻译',
    ),
    ModeItemModel(
      name: '不懂问我',
      color: Color(0xffeec9d2),
      introduction: '拍照识别物体类别',
    ),
    ModeItemModel(
      name: 'Fast',
      color: Color.fromRGBO(253, 133, 53, 1),
      introduction: '测试',
    ),
  ];
  selectMode(ModeItemModel mode,BuildContext context) {
    _selectedMode = mode;
    update();
    myhandle(mode.name, context);
  }
  Future<void> myhandle(String name,BuildContext context) async {
    if(name=="CameraOCR"){
      pickCamera();
      createPage(context);
    }
    else if(name=="ImageOCR"){
        pickImage();
        createPage(context);
      }
    else if(name=="LocalCameraOCR"){
      pickCamera();
      Loading.show(context);
      await localCreatePage(context);
      Loading.dismiss(context);
    }
    else if(name=="LocalImageOCR"){
      pickImage;
      Loading.show(context);
      localCreatePage(context);
      Loading.dismiss(context);
    }
    else if(name=="不懂问我"){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageLabelView()));
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
    getOCR().then((value) {
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
  Future<void> localCreatePage(BuildContext context) async {
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.chinese);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;
    //停用
    // Navigator.push(context, MaterialPageRoute(
    //     builder: (context)
    //     {
    //       return NewsPage(id: -1,
    //           title: 'OCR识别结果',
    //           author: 'plack',
    //           type: 'ocr',
    //           content: text);
    //     }));
  }
}