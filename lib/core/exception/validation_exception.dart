import 'business_exception.dart';
import 'exception_type.dart';

class BaseValidationException extends BaseBusinessException {
  BaseValidationException({
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
