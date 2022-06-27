import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plack/component/Config/UserConfig.dart';

Future<void> logoutUser() async {

  resetToken("");
  await Get.deleteAll(force: true); //deleting all controllers
  Phoenix.rebirth(Get.context!); // Restarting app
  Get.reset(); // resetting getx
}
