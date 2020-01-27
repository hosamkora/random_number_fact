import 'package:random_number_fact/api/number_data_api.dart';
import 'package:random_number_fact/models/number_data.dart';

class NumberDataRepo {
  final NumberDataApi numberDataApi;
  NumberDataRepo(this.numberDataApi);

  Future<NumberData> getNumberData(String type, int number) async {
    return await numberDataApi.getTriviaData(number, type);
  }
}
