import 'exception_type.dart';
import 'base_exception.dart';

class BaseBusinessException extends BaseException {
  BaseBusinessException({
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
