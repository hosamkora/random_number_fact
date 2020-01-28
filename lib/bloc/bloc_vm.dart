import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_number_fact/bloc/events.dart';
import 'package:random_number_fact/bloc/states.dart';

import '../repository/number_data_repo.dart';

class BlocVM extends Bloc<Event, Status> {
  final NumberDataRepo client;
  BlocVM(this.client);

  @override
  Status get initialState => Initial();
  @override
  void onTransition(Transition<Event, Status> transition) {
    print("Transtaiont");
    super.onTransition(transition);
  }

  @override
  Stream<Status> mapEventToState(Event event) async* {
    if (event is Update) {
      yield* update(event);
    }
  }

  Stream<Status> update(Update update) async* {
    yield Loading();
    try {
      final payload = await client.getNumberData(update.type, update.number);
      yield Loaded(payload);
    } catch (e) {
      yield Error("Error");
    }
  }
}
