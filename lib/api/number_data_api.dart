import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../models/number_data.dart';

part 'number_data_api.g.dart';

@RestApi(baseUrl: 'http://numbersapi.com')
abstract class NumberDataApi {
  factory NumberDataApi(Dio dio) = _NumberDataApi;

  @GET("/{number}/{type}?json")
  Future<NumberData> getTriviaData(
    @Path('number') int number,
    @Path('type') String type,
  );
}
