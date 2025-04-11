// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageResModel _$MessageResModelFromJson(Map<String, dynamic> json) =>
    MessageResModel(
      content: json['content'] as String,
      type: $enumDecode(_$ChatTypeEnumMap, json['type']),
      title: json['title'] as String?,
      sessionId: json['sessionId'] as String?,
    );

Map<String, dynamic> _$MessageResModelToJson(MessageResModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'type': _$ChatTypeEnumMap[instance.type]!,
      'title': instance.title,
      'sessionId': instance.sessionId,
    };

const _$ChatTypeEnumMap = {
  ChatType.ai: 'ai',
  ChatType.system: 'system',
  ChatType.human: 'human',
};
