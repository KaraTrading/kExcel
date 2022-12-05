import 'io_exception.dart';
import 'exception_type.dart';

class BaseFileException extends BaseIOException {
  String? path;
  String? format;

  BaseFileException({
    required BaseExceptionType type,
    String? friendlyMessage,
    String? developerMessage,
    int? code,
    this.path,
    this.format,
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
      'path': path,
      'format': format,
    });
    return json;
  }
}
