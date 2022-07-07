import 'package:plack/models/Data.dart';

import 'News.dart';

/// News : [{"id":1,"creatorId":null,"creatorName":null,"modifierId":null,"modifierName":null,"gmtCreate":"2022-06-25 16:25:17","gmtModified":null,"newsTitle":"测试","newsType":"finance","author":"测试","content":"测试"}]
/// total : 3
/// size : 1
/// current : 1
/// orders : []
/// optimizeCountSql : true
/// searchCount : true
/// countId : null
/// maxLimit : null
/// pages : 3

class NewsList extends Data {
  NewsList({
      this.news, 
      this.total, 
      this.size, 
      this.current, 
      this.orders, 
      this.optimizeCountSql, 
      this.searchCount, 
      this.countId, 
      this.maxLimit, 
      this.pages,});

  @override
  NewsList.fromJson(dynamic json) {
    if (json['records'] != null) {
      news = [];
      json['records'].forEach((v) {
        news?.add(News.fromJson(v));
      });
    }
    total = json['total'];
    size = json['size'];
    current = json['current'];
    if (json['orders'] != null) {
      orders = [];
    }
    optimizeCountSql = json['optimizeCountSql'];
    searchCount = json['searchCount'];
    countId = json['countId'];
    maxLimit = json['maxLimit'];
    pages = json['pages'];
  }
  List<News>? news;
  int? total;
  int? size;
  int? current;
  List<dynamic>? orders;
  bool? optimizeCountSql;
  bool? searchCount;
  dynamic countId;
  dynamic maxLimit;
  int? pages;
NewsList copyWith({  List<News>? news,
  int? total,
  int? size,
  int? current,
  List<dynamic>? orders,
  bool? optimizeCountSql,
  bool? searchCount,
  dynamic countId,
  dynamic maxLimit,
  int? pages,
}) => NewsList(  news: news ?? this.news,
  total: total ?? this.total,
  size: size ?? this.size,
  current: current ?? this.current,
  orders: orders ?? this.orders,
  optimizeCountSql: optimizeCountSql ?? this.optimizeCountSql,
  searchCount: searchCount ?? this.searchCount,
  countId: countId ?? this.countId,
  maxLimit: maxLimit ?? this.maxLimit,
  pages: pages ?? this.pages,
);
  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (news != null) {
      map['records'] = news?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    map['size'] = size;
    map['current'] = current;
    if (orders != null) {
      map['orders'] = orders?.map((v) => v.toJson()).toList();
    }
    map['optimizeCountSql'] = optimizeCountSql;
    map['searchCount'] = searchCount;
    map['countId'] = countId;
    map['maxLimit'] = maxLimit;
    map['pages'] = pages;
    return map;
  }

}
