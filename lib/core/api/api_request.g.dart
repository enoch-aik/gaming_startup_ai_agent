// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiRequest _$ApiRequestFromJson(Map<String, dynamic> json) => ApiRequest(
  op: json['op'] as String,
  params:
      (json['params'] as List<dynamic>)
          .map((e) => ApiParam.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ApiRequestToJson(ApiRequest instance) =>
    <String, dynamic>{
      'op': instance.op,
      'params': instance.params.map((e) => e.toJson()).toList(),
    };
