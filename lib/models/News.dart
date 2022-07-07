import 'package:plack/controller/newsController.dart';

/// id : 1
/// creatorId : 1
/// creatorName : ""
/// modifierId : 1
/// modifierName : ""
/// gmtCreate : "2022-06-25 16:25:17"
/// gmtModified : ""
/// newsTitle : "测试"
/// newsType : "finance"
/// author : "测试"
/// content : "测试"

class News {
  News({
      this.id, 
      this.creatorId, 
      this.creatorName, 
      this.modifierId, 
      this.modifierName, 
      this.gmtCreate, 
      this.gmtModified, 
      this.newsTitle, 
      this.newsType, 
      this.author, 
      this.content,});

  News.fromJson(dynamic json) {
    id = json['id'];
    creatorId = json['creatorId'];
    creatorName = json['creatorName'];
    modifierId = json['modifierId'];
    modifierName = json['modifierName'];
    gmtCreate = json['gmtCreate'];
    gmtModified = json['gmtModified'];
    newsTitle = json['newsTitle'];
    newsType = newsController.typeReConvert(json['newsType']);
    author = json['author'];
    content = json['content'];
  }
  int? id;
  int? creatorId;
  String? creatorName;
  int? modifierId;
  String? modifierName;
  String? gmtCreate;
  String? gmtModified;
  String? newsTitle;
  String? newsType;
  String? author;
  String? content;
News copyWith({  int? id,
  int? creatorId,
  String? creatorName,
  int? modifierId,
  String? modifierName,
  String? gmtCreate,
  String? gmtModified,
  String? newsTitle,
  String? newsType,
  String? author,
  String? content,
}) => News(  id: id ?? this.id,
  creatorId: creatorId ?? this.creatorId,
  creatorName: creatorName ?? this.creatorName,
  modifierId: modifierId ?? this.modifierId,
  modifierName: modifierName ?? this.modifierName,
  gmtCreate: gmtCreate ?? this.gmtCreate,
  gmtModified: gmtModified ?? this.gmtModified,
  newsTitle: newsTitle ?? this.newsTitle,
  newsType: newsType ?? this.newsType,
  author: author ?? this.author,
  content: content ?? this.content,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['creatorId'] = creatorId;
    map['creatorName'] = creatorName;
    map['modifierId'] = modifierId;
    map['modifierName'] = modifierName;
    map['gmtCreate'] = gmtCreate;
    map['gmtModified'] = gmtModified;
    map['newsTitle'] = newsTitle;
    map['newsType'] = newsType;
    map['author'] = author;
    map['content'] = content;
    return map;
  }

}