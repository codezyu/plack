import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  News();

  late num id;
  late String name;
  late String full_name;
  late String author;
  late String description;
  late String topic;
  late num thumb_count;
  late num reading_count;
  late num share_count;
  late String pushed_at;
  late String created_at;
  late String updated_at;
  
  factory News.fromJson(Map<String,dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}
