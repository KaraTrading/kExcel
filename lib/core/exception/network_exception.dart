import 'network_exception_type.dart';
import 'io_exception.dart';
import 'exception_type.dart';

class BaseNetworkException extends BaseIOException {
  BaseNetworkExceptionType? networkExceptionType;
  dynamic error;

  BaseNetworkException({
    required BaseExceptionType type,
    String? friendlyMessage,
    String? developerMessage,
    int? code,
    this.networkExceptionType = BaseNetworkExceptionType.other,
    this.error,
  }) : super(
          type: type,
          friendlyMessage: friendlyMessage,
          developerMessage: developerMessage,
          code: code,
        );

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = super.toJson();
    json.addAll({
      'network exception type':
          networkExceptionType.toString().split('.').last.toUpperCase(),
      'error': error.toString(),
    });
    return json;
  }
}
