import 'io_exception.dart';
import 'exception_type.dart';
import 'database_operation.dart';

class BaseDatabaseException extends BaseIOException {
  String? databaseName;
  String? tableName;
  GigDatabaseOperation? operation;

  BaseDatabaseException({
    required BaseExceptionType type,
    String? friendlyMessage,
    String? developerMessage,
    int? code,
    this.databaseName,
    this.tableName,
    this.operation,
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
      'database name': databaseName,
      'table name': tableName,
      'operation': operation.toString().split('.').last.toUpperCase(),
    });
    return json;
  }
}
