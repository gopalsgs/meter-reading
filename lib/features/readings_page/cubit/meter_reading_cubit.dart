import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:meter_reading/core/error/error_codes.dart';
import 'package:meter_reading/core/error/failure.dart';
import 'package:meter_reading/core/models/reading_model.dart';
import 'package:meter_reading/core/services/db_service.dart';

part 'meter_reading_state.dart';

class MeterReadingCubit extends Cubit<MeterReadingState> {
  MeterReadingCubit() : super(MeterReadingInitial());

  void getAllReadings() async {
    emit(MeterReadingLoading());

    try {
      final meterReadings =
          await DatabaseManager.instance.fetchAllMeterReading();
      if ((meterReadings?.length ?? 0) > 0) {
        emit(MeterReadingLoaded(meterReadings));
      } else {
        emit(
          MeterReadingError(
            Failure(
              message: 'No Meters Found',
              erroCode: ErrorCode.uiError,
            ),
          ),
        );
      }
    } on Exception catch (e) {
      print(e);
      emit(MeterReadingError(Failure.unKnown()));
    }
  }
}
