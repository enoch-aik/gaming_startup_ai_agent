import 'package:json_annotation/json_annotation.dart';

part 'api_param.g.dart';

@JsonSerializable()
class ApiParam {
  final String name;
  final String value;

  const ApiParam({
    required this.name,
    required this.value,
  });

  factory ApiParam.fromJson(Map<String, dynamic> json) =>
      _$ApiParamFromJson(json);

  Map<String, dynamic> toJson() => _$ApiParamToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is ApiParam &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => super.hashCode ^ name.hashCode;
}
