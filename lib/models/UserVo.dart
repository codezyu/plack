import 'package:json_annotation/json_annotation.dart';

part 'UserVo.g.dart';

@JsonSerializable()
class UserVo {
  UserVo();

  late String userName;
  late String password;
  
  factory UserVo.fromJson(Map<String,dynamic> json) => _$UserVoFromJson(json);
  Map<String, dynamic> toJson() => _$UserVoToJson(this);
}
