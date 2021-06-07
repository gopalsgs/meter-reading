part of 'meter_reading_cubit.dart';

@immutable
abstract class MeterReadingState {}

class MeterReadingInitial extends MeterReadingState {}

class MeterReadingLoading extends MeterReadingState {}

class MeterReadingLoaded extends MeterReadingState {
  final List<MeterReading> meterReadings;
  MeterReadingLoaded(this.meterReadings);
}

class MeterReadingError extends MeterReadingState {
  final Failure failure;
  MeterReadingError(this.failure);
}
