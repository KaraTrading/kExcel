import '../local/secure_storage.dart';

abstract class BaseLocalDataSource<T> {

  abstract final String tableName;

  abstract final SecureStorage<T> storage;
}
