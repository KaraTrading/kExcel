import '../local/secure_storage.dart';

abstract class BaseLocalDataSource<T> {
  abstract final SecureStorage<T> storage;
}
