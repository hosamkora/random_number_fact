import 'package:equatable/equatable.dart';
import 'package:random_number_fact/models/number_data.dart';

abstract class Status extends Equatable {}

class Loading extends Status {
  @override
  List<Object> get props => [];
}

class Error extends Status {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}

class Loaded extends Status {
  final NumberData payload;

  Loaded(this.payload);

  @override
  List<Object> get props => [payload];
}

class Initial extends Status {
  @override
  List<Object> get props => [];
}
