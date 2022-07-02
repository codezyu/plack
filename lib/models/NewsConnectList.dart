/// NewsConnect : [{"id":25,"creatorId":1,"creatorName":"","modifierId":2,"modifierName":"","gmtCreate":"officia elit ipsum eiusmod in","gmtModified":"","userId":70,"newsId":58,"connectType":"velit irure consectetur adipisicing nostrud"},null]

class NewsConnectList {
  NewsConnectList({
      this.newsConnect,});

  NewsConnectList.fromJson(dynamic json) {
      newsConnect = [];
      json.forEach((v) {
        newsConnect?.add(NewsConnect.fromJson(v));
      });
  }
  List<NewsConnect>? newsConnect;
NewsConnectList copyWith({  List<NewsConnect>? newsConnect,
}) => NewsConnectList(  newsConnect: newsConnect ?? this.newsConnect,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (newsConnect != null) {
      map['NewsConnect'] = newsConnect?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 25
/// creatorId : 1
/// creatorName : ""
/// modifierId : 2
/// modifierName : ""
/// gmtCreate : "officia elit ipsum eiusmod in"
/// gmtModified : ""
/// userId : 70
/// newsId : 58
/// connectType : "velit irure consectetur adipisicing nostrud"

class NewsConnect {
  NewsConnect({
      this.id, 
      this.creatorId, 
      this.creatorName, 
      this.modifierId, 
      this.modifierName, 
      this.gmtCreate, 
      this.gmtModified, 
      this.userId, 
      this.newsId, 
      this.connectType,});

  NewsConnect.fromJson(dynamic json) {
    id = json['id'];
    creatorId = json['creatorId'];
    creatorName = json['creatorName'];
    modifierId = json['modifierId'];
    modifierName = json['modifierName'];
    gmtCreate = json['gmtCreate'];
    gmtModified = json['gmtModified'];
    userId = json['userId'];
    newsId = json['newsId'];
    connectType = json['connectType'];
  }
  int? id;
  int? creatorId;
  String? creatorName;
  int? modifierId;
  String? modifierName;
  String? gmtCreate;
  String? gmtModified;
  int? userId;
  int? newsId;
  String? connectType;
NewsConnect copyWith({  int? id,
  int? creatorId,
  String? creatorName,
  int? modifierId,
  String? modifierName,
  String? gmtCreate,
  String? gmtModified,
  int? userId,
  int? newsId,
  String? connectType,
}) => NewsConnect(  id: id ?? this.id,
  creatorId: creatorId ?? this.creatorId,
  creatorName: creatorName ?? this.creatorName,
  modifierId: modifierId ?? this.modifierId,
  modifierName: modifierName ?? this.modifierName,
  gmtCreate: gmtCreate ?? this.gmtCreate,
  gmtModified: gmtModified ?? this.gmtModified,
  userId: userId ?? this.userId,
  newsId: newsId ?? this.newsId,
  connectType: connectType ?? this.connectType,
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
    map['userId'] = userId;
    map['newsId'] = newsId;
    map['connectType'] = connectType;
    return map;
  }

}