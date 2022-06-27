// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News()
  ..id = json['id'] as num
  ..name = json['name'] as String
  ..full_name = json['full_name'] as String
  ..author = json['author'] as String
  ..description = json['description'] as String
  ..topic = json['topic'] as String
  ..thumb_count = json['thumb_count'] as num
  ..reading_count = json['reading_count'] as num
  ..share_count = json['share_count'] as num
  ..pushed_at = json['pushed_at'] as String
  ..created_at = json['created_at'] as String
  ..updated_at = json['updated_at'] as String;

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.full_name,
      'author': instance.author,
      'description': instance.description,
      'topic': instance.topic,
      'thumb_count': instance.thumb_count,
      'reading_count': instance.reading_count,
      'share_count': instance.share_count,
      'pushed_at': instance.pushed_at,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
