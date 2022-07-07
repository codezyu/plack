import 'package:get/get.dart';
import 'package:plack/controller/dataController.dart';
import 'package:plack/controller/userInfoController.dart';
import 'package:plack/function/Assitsant/manager.dart';

import '../function/login/locator.dart';
import '../function/login/services/camera.service.dart';
import '../function/login/services/face_detector_service.dart';
import '../function/login/services/ml_service.dart';
class initController extends GetxController{
  @override
  Future<void> onReady() async {
    super.onReady();
    dataController data=Get.find();
    userInfoController user=Get.find();
    MLService _mlService = locator<MLService>();
    FaceDetectorService _mlKitService = locator<FaceDetectorService>();
    CameraService _cameraService = locator<CameraService>();
    await _cameraService.initialize();
    await _mlService.initialize();
    _mlKitService.initialize();
    AssistantManager manager=new AssistantManager();
    manager.createPorcupineManager();
      if(data.getToken()==null||data.getToken().isEmpty) {
        Get.offNamed('/login');
      }else{
          Get.offNamed('/main');
        }
  }
}