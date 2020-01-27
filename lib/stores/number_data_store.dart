import 'package:mobx/mobx.dart';
import 'package:random_number_fact/models/number_data.dart';
import 'package:random_number_fact/repository/number_data_repo.dart';

part 'number_data_store.g.dart';

enum RequestState {
  loading,
  loaded,
  error,
}

class NumberDataStore = _NumberDataStoreBase with _$NumberDataStore;

abstract class _NumberDataStoreBase with Store {
  _NumberDataStoreBase(this.client);
  final NumberDataRepo client;

  @computed
  RequestState get state {
    switch (_numberData.status) {
      case FutureStatus.fulfilled:
        return RequestState.loaded;
      case FutureStatus.pending:
        return RequestState.loading;
      case FutureStatus.rejected:
        return RequestState.error;
      default:
        return null;
    }
  }

  @observable
  ObservableFuture<NumberData> _numberData = ObservableFuture.value(null);

  @observable
  int number = 0;

  @observable
  String fact = "--";

  @action
  void getTriviaData(int num, String type) {
    _numberData = client.getNumberData(type, num).asObservable();
    _numberData.catchError((err) {
      print("error");
    }).then((val) {
      number = val.number;
      fact = val.text;
    });
  }
}
