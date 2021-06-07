import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:meter_reading/core/error/failure.dart';
import 'package:meter_reading/core/models/meter_model.dart';
import 'package:meter_reading/core/services/db_service.dart';

part 'add_meter_state.dart';

class AddMeterCubit extends Cubit<AddMeterState> {
  AddMeterCubit() : super(AddMeterInitial());

  void addMeter({
    @required String name,
    @required String serialNumber,
    @required DateTime installationDate,
    @required DateTime outOfServiceDate,
  }) async {
    
    if (name.length < 4) {
      emit(
        AddMeterError(
          Failure.validation(message: 'Enter meter name (min 4 chars)'),
        ),
      );
      return;
    }
    if (serialNumber.length < 4) {
      emit(
        AddMeterError(
          Failure.validation(message: 'Enter Serial Number (min 4 chars)'),
        ),
      );
      return;
    }
    if (installationDate == null) {
      emit(
        AddMeterError(
          Failure.validation(message: 'Set Installation Date'),
        ),
      );
      return;
    }
    if (outOfServiceDate == null) {
      emit(
        AddMeterError(
          Failure.validation(message: 'Set Out Of Service Date'),
        ),
      );
      return;
    }

    try {
      final result = await DatabaseManager.instance.addMeter(
        Meter(
          name: name,
          serialNumber: serialNumber,
          installationDate: installationDate,
          outOfServiceDate: outOfServiceDate,
        ),
      );
      if (result != 0) {
        emit(AddMeterSuccess());
      } else {
        emit(AddMeterError(Failure.unKnown()));
      }
    } on Exception catch (e) {
      print(e);
      emit(AddMeterError(Failure.unKnown()));
    }
  }
}
