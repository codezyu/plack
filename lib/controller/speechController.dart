import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class speechController extends GetxController{
  FlutterTts flutterTts = FlutterTts();
  @override
  void onReady(){
    flutterTts.setLanguage("ch");
    flutterTts.setSpeechRate(0.4);
  }
}