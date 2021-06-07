import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:meter_reading/core/error/error_codes.dart';
import 'package:meter_reading/core/error/failure.dart';
import 'package:meter_reading/core/models/meter_model.dart';
import 'package:meter_reading/core/services/db_service.dart';

part 'meter_state.dart';

class MeterCubit extends Cubit<MeterState> {
  MeterCubit() : super(MeterInitial());

  void getAllMeters() async {
    emit(MeterLoading());

    try {
      final meters = await DatabaseManager.instance.fetchAllMeter();
      if ((meters?.length ?? 0) > 0) {
        emit(MeterLoaded(meters));
      } else {
        emit(
          MeterLoadingError(
            Failure(message: 'No Meters Found', erroCode: ErrorCode.uiError),
          ),
        );
      }
    } on Exception catch (e) {
      print(e);
      emit(MeterLoadingError(Failure.unKnown()));
    }
  }
}
