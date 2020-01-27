import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpClient {
  static Dio _dio;

  static Dio getInstance() {
    if (_dio == null)
      _dio = Dio()
        ..interceptors.add(PrettyDioLogger(
          request: true,
          requestHeader: true,
          responseBody: true,
        ));

    return _dio;
  }
}
