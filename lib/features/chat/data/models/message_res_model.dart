import 'package:json_annotation/json_annotation.dart';

part 'message_res_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MessageResModel {
  final String content;
  @JsonKey()
  final ChatType type;
  final String? title;
  final String? sessionId;
  @JsonKey(defaultValue: false)
  final bool? shouldAnimate;

  MessageResModel({
    required this.content,
    required this.type,
    this.title,
    this.sessionId,
    this.shouldAnimate = false,
  });

  factory MessageResModel.error() => MessageResModel(
    content: 'Unable to generate response, try again later',
    type: ChatType.ai,
  );

  factory MessageResModel.fromJson(Map<String, dynamic> json) =>
      _$MessageResModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageResModelToJson(this);
}

enum ChatType { ai, system, human }
