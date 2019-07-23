import 'package:meta/meta.dart';
import 'package:okhi_flutter_widget/src/models/okhi_error_code.dart';
import 'package:okhi_flutter_widget/src/models/transmission.dart';

class OkHiError {
  final OkHiErrorCode code;
  final String message;

  OkHiError({@required this.code, @required this.message});

  OkHiError.fromTransmission(Transmission transmission)
      : this.code = transmission.message == 'fatal_exit'
            ? OkHiErrorCode.fatal_exit
            : OkHiErrorCode.unknown_error,
        this.message = transmission.payload['body'];
}
