import 'package:super_enum/super_enum.dart';

abstract class Event extends Equatable {}

class Update extends Event {
  final int number;
  final String type;

  Update(this.number, this.type);

  @override
  List<Object> get props => [number as Object, type as Object];
}
