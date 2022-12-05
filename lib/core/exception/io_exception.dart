import 'base_exception.dart';
import 'exception_type.dart';

class BaseIOException extends BaseException {
  BaseIOException({
    required BaseExceptionType type,
    String? friendlyMessage,
    String? developerMessage,
    int? code,
  }) : super(
          type: type,
          friendlyMessage: friendlyMessage,
          developerMessage: developerMessage,
          code: code,
        );
}
