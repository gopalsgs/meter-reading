part of 'add_reading_cubit.dart';

@immutable
abstract class AddReadingState {}


class LoadingLastReading extends AddReadingState {}

class LoadedLastReading extends AddReadingState {}

class LastReadingLoadError extends AddReadingState {
  final Failure failure;
  LastReadingLoadError(this.failure);
}

class AddReadingInitial extends AddReadingState {}

class AddReadingSuccess extends AddReadingState {}

class AddReadingError extends AddReadingState {
  final Failure failure;
  AddReadingError(this.failure);
}
