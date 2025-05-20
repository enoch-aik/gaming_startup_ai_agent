import 'package:json_annotation/json_annotation.dart';

import 'api_param.dart';

part 'api_request.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiRequest {
  final String op;
  final List<ApiParam> params;

  const ApiRequest({
    required this.op,
    required this.params,
  });

  Map<String, dynamic> toJson() => _$ApiRequestToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiRequest && runtimeType == other.runtimeType && op == other.op;

  @override
  int get hashCode => op.hashCode;
}
