// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_data_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _NumberDataApi implements NumberDataApi {
  _NumberDataApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://numbersapi.com';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getTriviaData(number, type) async {
    ArgumentError.checkNotNull(number, 'number');
    ArgumentError.checkNotNull(type, 'type');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/$number/$type?json',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NumberData.fromJson(_result.data);
    return Future.value(value);
  }
}
