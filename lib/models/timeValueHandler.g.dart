// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeValueHandler.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetClass _$SetClassFromJson(Map<String, dynamic> json) => SetClass(
      timeList: (json['timeList'] as List<dynamic>?)
          ?.map((e) => TimeClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      sets: json['sets'] as int?,
      grpName: json['grpName'] as String?,
    );

Map<String, dynamic> _$SetClassToJson(SetClass instance) => <String, dynamic>{
      'timeList': instance.timeList?.map((e) => e.toJson()).toList(),
      'sets': instance.sets,
      'grpName': instance.grpName,
    };

TimeClass _$TimeClassFromJson(Map<String, dynamic> json) => TimeClass(
      isWork: json['isWork'] as bool?,
      sec: json['sec'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TimeClassToJson(TimeClass instance) => <String, dynamic>{
      'sec': instance.sec,
      'isWork': instance.isWork,
      'name': instance.name,
    };

SavedAdvanced _$SavedAdvancedFromJson(Map<String, dynamic> json) =>
    SavedAdvanced(
      name: json['name'] as String?,
      groups: (json['groups'] as List<dynamic>?)
          ?.map((e) => SetClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalTime: json['totalTime'] as int?,
    );

Map<String, dynamic> _$SavedAdvancedToJson(SavedAdvanced instance) =>
    <String, dynamic>{
      'name': instance.name,
      'groups': instance.groups?.map((e) => e.toJson()).toList(),
      'totalTime': instance.totalTime,
    };
