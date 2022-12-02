import '../local/secure_storage.dart';

abstract class BaseLocalDataSource<T> {
  final String tableName;
  BaseLocalDataSource(this.tableName);

  abstract final SecureStorage<T> storage;
}
