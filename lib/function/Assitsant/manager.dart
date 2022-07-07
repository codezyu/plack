import 'package:get/get.dart';
import 'package:plack/common/constants.dart';
import 'package:plack/function/cameraPage/cameraPage.dart';
import 'package:porcupine_flutter/porcupine_error.dart';
import 'package:porcupine_flutter/porcupine_manager.dart';

import '../../common/config.dart';

class AssistantManager{
  var accessKey = "CmLy54oajQJt9yUbGyU6N1TV+/2gq4KokNpmS+dlCAGplGwQ7Cg59g=="; // AccessKey obtained from Picovoice Console (https://console.picovoice.ai/)
  void createPorcupineManager() async {
    try{
      var _porcupineManager = await PorcupineManager.fromKeywordPaths(
          accessKey,
          ["assets/ml/Hi-Plack_en_android_v2_1_0.ppn","assets/ml/It--s-Me_en_android_v2_1_0.ppn","assets/ml/Read-News_en_android_v2_1_0.ppn"],
          _wakeWordCallback);
      await _porcupineManager.start();
    } on PorcupineException catch (err) {
      // handle porcupine init error
    }
  }
  void _wakeWordCallback(int keywordIndex){
    if(keywordIndex == 0){
      indexOfMenu.value=Menu['camera']!;
      Get.offNamed("/main");
    }
    if(keywordIndex == 1){
      indexOfMenu.value=Menu['favourite']!;
      Get.offNamed("/main");
    }
    if(keywordIndex == 2){
      indexOfMenu.value=Menu['home']!;
      Get.offNamed("/main");
    }
  }

}