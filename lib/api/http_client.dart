import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpClient {
  static Dio _dio;
  static PrettyDioLogger _prettyDioLogger;
  static bool _logging = false;

  static bool get logging => _logging;

  static Dio getInstance() {
    if (_dio == null)
      _dio = Dio()
          // ..interceptors.add(PrettyDioLogger(
          //   request: true,
          //   requestHeader: true,
          //   responseBody: true,
          // ))
          ;

    return _dio;
  }

  static void enableLogging(bool value) {
    if (value == _logging) return;

    _logging = value;
    if (value == true) {
      _prettyDioLogger ??= PrettyDioLogger(
        request: true,
        requestBody: true,
        responseBody: true,
      );
      _dio.interceptors.add(_prettyDioLogger);
      return;
    }

    _dio.interceptors.remove(_prettyDioLogger);
  }
}
