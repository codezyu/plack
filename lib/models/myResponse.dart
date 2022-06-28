import 'package:plack/models/Data.dart';
import 'package:plack/models/UserInfo.dart';

import 'NewsList.dart';

/// errno : 0
/// data : {"NewsList":[{"id":1,"creatorId":1,"creatorName":null,"modifierId":null,"modifierName":null,"gmtCreate":"2022-06-25 16:25:17","gmtModified":null,"newsTitle":"测试","newsType":"Business","author":"测试","content":"测试"},{"id":3,"creatorId":null,"creatorName":null,"modifierId":null,"modifierName":null,"gmtCreate":"2022-06-27 06:59:33","gmtModified":null,"newsTitle":"测试1","newsType":"Business","author":"不是测试","content":"你觉得回收好吗"},{"id":4,"creatorId":null,"creatorName":null,"modifierId":null,"modifierName":null,"gmtCreate":"2022-06-27 06:59:37","gmtModified":null,"newsTitle":"真的不是测试","newsType":"Business","author":"cc","content":"你觉得你很幽默？"}],"total":3,"size":3,"current":1,"orders":[],"optimizeCountSql":true,"searchCount":true,"countId":null,"maxLimit":null,"pages":1}
/// errmsg : "成功"

class MyResponse {
  MyResponse({
      this.errno, 
      this.data, 
      this.errmsg,});

  MyResponse.fromJson(dynamic json,int type) {
    errno = json['errno'];
    if(type==1)
    data = json['data'] != null ? NewsList.fromJson(json['data']) : null;
    else if(type==2)
      data = json['data'] != null ? UserInfo.fromJson(json['data']) : null;
    else{
      data = json['data'] != null ? Data.fromJson(json['data']) : null;
    }
    errmsg = json['errmsg'];
  }
  int? errno;
  Object? data;
  String? errmsg;
MyResponse copyWith({  int? errno,
  Object? data,
  String? errmsg,
}) => MyResponse(  errno: errno ?? this.errno,
  data: data ?? this.data,
  errmsg: errmsg ?? this.errmsg,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errno'] = errno;
    if (data != null) {
      map['data'] = null;
    }
    map['errmsg'] = errmsg;
    return map;
  }

}

