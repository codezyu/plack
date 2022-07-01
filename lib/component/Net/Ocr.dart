import 'package:dio/dio.dart';

import '../../common/config.dart';
import '../../common/constants.dart';
import '../../models/myResponse.dart';


Future<String?> ocr(String base64) async {
  if(base64.isNotEmpty) {
    String url = ip + ':' + port + ocrUrl;
    String data="{\"base64\":"+"\""+base64+"\""+"}";
    Response response = await dio.post(url,data:data);
    if(response.statusCode==200){
      return response.data['data'];
    }
  }else
    return "";
}