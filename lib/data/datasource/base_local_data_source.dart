import '../local/database.dart';

abstract class BaseLocalDataSource<T> {
  abstract final Database<T> storage;
}
