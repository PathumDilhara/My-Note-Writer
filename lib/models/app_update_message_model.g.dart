// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUpdateMessageModel _$AppUpdateMessageModelFromJson(
        Map<String, dynamic> json) =>
    AppUpdateMessageModel(
      id: (json['id'] as num?)?.toInt(),
      updateTitle: json['updateTitle'] as String,
      updateDescription: json['updateDescription'] as String,
      updateUrl: json['updateUrl'] as String,
      newVersion: json['newVersion'] as String,
      canIgnore: json['canIgnore'] as bool,
    );

Map<String, dynamic> _$AppUpdateMessageModelToJson(
        AppUpdateMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updateTitle': instance.updateTitle,
      'updateDescription': instance.updateDescription,
      'updateUrl': instance.updateUrl,
      'newVersion': instance.newVersion,
      'canIgnore': instance.canIgnore,
    };
