import 'package:dio/dio.dart';

//used to check api response
Future<void> apiResponseChecker(
  Response<dynamic> response, {
  bool fromServerpod = false,
  bool returnBool = true,
}) async {
  if (!fromServerpod) {
    bool isSuccess = returnBool ? response.data['result'] == true : true;
    if (!isSuccess) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.unknown,
        error: response.data['error'],
      );
    }
  }
}
