import 'package:json_annotation/json_annotation.dart';

part 'message_res_model.g.dart';

@JsonSerializable()
class MessageResModel {
  final String content;
  @JsonKey(
    unknownEnumValue: JsonKey.nullForUndefinedEnumValue,
  )
  final ChatType type;

  MessageResModel({required this.content, required this.type});

  factory MessageResModel.fromJson(Map<String, dynamic> json) =>
      _$MessageResModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageResModelToJson(this);
}

enum ChatType { ai, system, human }
