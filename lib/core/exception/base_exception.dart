import 'package:flutter/foundation.dart';
import 'exception_type.dart';

class BaseException implements Exception {
  BaseExceptionType type;
  String? friendlyMessage;
  String? developerMessage;
  int? code;

  BaseException({
    required this.type,
    this.friendlyMessage,
    this.developerMessage,
    this.code,
  });

  @override
  String toString() {
    if (kReleaseMode || (developerMessage?.isEmpty ?? true)) {
      return (friendlyMessage ?? '');
    } else {
      return (developerMessage ?? '');
    }
  }

  String getErrorMessage() {
    if (type == BaseExceptionType.developer) {
      return (kReleaseMode) ? (friendlyMessage ?? '') : _format(toJson());
    }

    return toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'friendly message': friendlyMessage,
      'developer message': developerMessage,
    };
  }

  String _format(Map<String, dynamic> fields) {
    String formattedFields = '';
    fields.forEach((key, value) {
      formattedFields += '$key : $value \n';
    });

    return formattedFields;
  }
}
