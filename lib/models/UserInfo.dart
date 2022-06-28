import 'package:plack/models/Data.dart';

/// id : 1
/// creatorId : 1
/// creatorName : "1"
/// modifierId : 1
/// modifierName : "1"
/// gmtCreate : "2022-06-25 09:29:00"
/// gmtModified : "1"
/// userName : "mawang"
/// password : "123456"
/// creditPoint : 1
/// sign : 1
/// address : ""
/// realName : ""
/// state : "NORMAL"
/// email : ""
/// preferTaskType : null
/// mobile : ""
/// studentId : ""
/// beDeleted : 0

class UserInfo extends Data {
  UserInfo({
      this.id, 
      this.creatorId, 
      this.creatorName, 
      this.modifierId, 
      this.modifierName, 
      this.gmtCreate, 
      this.gmtModified, 
      this.userName, 
      this.password, 
      this.creditPoint, 
      this.sign, 
      this.address, 
      this.realName, 
      this.state, 
      this.email, 
      this.preferTaskType, 
      this.mobile, 
      this.studentId, 
      this.beDeleted,});

  @override
  UserInfo.fromJson(dynamic json) {
    id = json['id'];
    creatorId = json['creatorId'];
    creatorName = json['creatorName'];
    modifierId = json['modifierId'];
    modifierName = json['modifierName'];
    gmtCreate = json['gmtCreate'];
    gmtModified = json['gmtModified'];
    userName = json['userName'];
    password = json['password'];
    creditPoint = json['creditPoint'];
    sign = json['sign'];
    address = json['address'];
    realName = json['realName'];
    state = json['state'];
    email = json['email'];
    preferTaskType = json['preferTaskType'];
    mobile = json['mobile'];
    studentId = json['studentId'];
    beDeleted = json['beDeleted'];
  }
  int? id;
  int? creatorId;
  String? creatorName;
  int? modifierId;
  String? modifierName;
  String? gmtCreate;
  String? gmtModified;
  String? userName;
  String? password;
  int? creditPoint;
  int? sign;
  String? address;
  String? realName;
  String? state;
  String? email;
  dynamic preferTaskType;
  String? mobile;
  String? studentId;
  int? beDeleted;
UserInfo copyWith({  int? id,
  int? creatorId,
  String? creatorName,
  int? modifierId,
  String? modifierName,
  String? gmtCreate,
  String? gmtModified,
  String? userName,
  String? password,
  int? creditPoint,
  int? sign,
  String? address,
  String? realName,
  String? state,
  String? email,
  dynamic preferTaskType,
  String? mobile,
  String? studentId,
  int? beDeleted,
}) => UserInfo(  id: id ?? this.id,
  creatorId: creatorId ?? this.creatorId,
  creatorName: creatorName ?? this.creatorName,
  modifierId: modifierId ?? this.modifierId,
  modifierName: modifierName ?? this.modifierName,
  gmtCreate: gmtCreate ?? this.gmtCreate,
  gmtModified: gmtModified ?? this.gmtModified,
  userName: userName ?? this.userName,
  password: password ?? this.password,
  creditPoint: creditPoint ?? this.creditPoint,
  sign: sign ?? this.sign,
  address: address ?? this.address,
  realName: realName ?? this.realName,
  state: state ?? this.state,
  email: email ?? this.email,
  preferTaskType: preferTaskType ?? this.preferTaskType,
  mobile: mobile ?? this.mobile,
  studentId: studentId ?? this.studentId,
  beDeleted: beDeleted ?? this.beDeleted,
);
  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['creatorId'] = creatorId;
    map['creatorName'] = creatorName;
    map['modifierId'] = modifierId;
    map['modifierName'] = modifierName;
    map['gmtCreate'] = gmtCreate;
    map['gmtModified'] = gmtModified;
    map['userName'] = userName;
    map['password'] = password;
    map['creditPoint'] = creditPoint;
    map['sign'] = sign;
    map['address'] = address;
    map['realName'] = realName;
    map['state'] = state;
    map['email'] = email;
    map['preferTaskType'] = preferTaskType;
    map['mobile'] = mobile;
    map['studentId'] = studentId;
    map['beDeleted'] = beDeleted;
    return map;
  }

}