abstract class SecureStorage<T> {

  final String tableName;

  SecureStorage(this.tableName);

  Future<bool> delete(T data);

  Future<bool> deleteById(int id);

  Future<T?> getById(int id);

  Future<List<T>?> getAll();

  Future<T?> findFirst(String query);

  Future<List<T>?> findAll(String query);

  Future<T?> put(T data);

  Future<T?> add(T data);

}
