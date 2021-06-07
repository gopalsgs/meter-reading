part of 'add_meter_cubit.dart';

@immutable
abstract class AddMeterState {}

class AddMeterInitial extends AddMeterState {}

class AddMeterSuccess extends AddMeterState {}

class AddMeterError extends AddMeterState {
  final Failure failure;
  AddMeterError(this.failure);
}
