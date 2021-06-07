part of 'meter_cubit.dart';

@immutable
abstract class MeterState {}

class MeterInitial extends MeterState {}

class MeterLoading extends MeterState {}

class MeterLoaded extends MeterState {
  final List<Meter> meters;
  MeterLoaded(this.meters);
}

class MeterLoadingError extends MeterState {
  final Failure failure;
  MeterLoadingError(this.failure);
}
