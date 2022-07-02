/// favorCount : 26
/// collectCount : 87
/// browseCount : 100

class Number {
  Number({
      this.favorCount, 
      this.collectCount, 
      this.browseCount,});

  Number.fromJson(dynamic json) {
    favorCount = json['favorCount'];
    collectCount = json['collectCount'];
    browseCount = json['browseCount'];
  }
  int? favorCount;
  int? collectCount;
  int? browseCount;
Number copyWith({  int? favorCount,
  int? collectCount,
  int? browseCount,
}) => Number(  favorCount: favorCount ?? this.favorCount,
  collectCount: collectCount ?? this.collectCount,
  browseCount: browseCount ?? this.browseCount,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['favorCount'] = favorCount;
    map['collectCount'] = collectCount;
    map['browseCount'] = browseCount;
    return map;
  }

}