import 'package:flutter/cupertino.dart';
import 'package:meter_reading/core/error/error_codes.dart';

class Failure {
  final String message;
  final int erroCode;

  Failure({@required this.message, @required this.erroCode});

  factory Failure.unKnown({
    String message = 'Something went wrong!',
  }) {
    return Failure(
      erroCode: ErrorCode.unKnownError,
      message: message,
    );
  }

  factory Failure.validation({@required String message}) {
    return Failure(
      erroCode: ErrorCode.formValidationError,
      message: message,
    );
  }
}
