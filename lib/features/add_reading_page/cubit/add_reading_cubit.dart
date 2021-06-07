import 'dart:io';

import 'package:bloc/bloc.dart';
// import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:meter_reading/core/error/failure.dart';
import 'package:meter_reading/core/models/reading_model.dart';
import 'package:meter_reading/core/services/db_service.dart';
import 'package:meter_reading/features/readings_page/cubit/meter_reading_cubit.dart';

part 'add_reading_state.dart';

class AddReadingCubit extends Cubit<AddReadingState> {
  AddReadingCubit() : super(AddReadingInitial());

  MeterReading lastReading;

  void addNewReading({
    @required DateTime date,
    @required int meterId,
    @required String reading, File imageFile,
  }) async {
    final readingInt = int.tryParse(reading) ?? 0;

    if ((lastReading?.reading != null) && lastReading.reading > readingInt) {
      emit(
        AddReadingError(
          Failure.validation(message: 'Reading is less than preivous'),
        ),
      );
      return;
    }

    // final location = await Location.instance.getLocation();

    final MeterReading meterReading = MeterReading(
      date: date,
      meterId: meterId,
      reading: readingInt,
      image: imageFile != null ?? MeterReading.encodeImage(imageFile),
      latitude: null,
      longitude: null,
    );
    try {
      final result =
          await DatabaseManager.instance.addMeterReading(meterReading);
      if (result != 0) {
        emit(AddReadingSuccess());
      } else {
        emit(AddReadingError(Failure.unKnown()));
      }
    } on Exception catch (e) {
      print(e);
      emit(AddReadingError(Failure.unKnown()));
    }
  }

  void loadLastReading(int id) async {
    emit(LoadingLastReading());

    try {
      final lastReading = await DatabaseManager.instance.fetchMeterReading(id);
      this.lastReading = lastReading;
      emit(LoadedLastReading());
    } on Exception catch (e) {
      print(e);
      emit(LastReadingLoadError(Failure.unKnown()));
    }
  }
}
