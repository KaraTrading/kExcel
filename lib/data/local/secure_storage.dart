abstract class SecureStorage<T> {

  Future<bool> delete(T data);

  Future<bool> deleteById(int id);

  Future<bool> deleteAll();

  Future<T?> getById(int id);

  Future<List<T>?> getByIds(List<int> ids);

  Future<List<T>?> getAll();

  Future<T?> findFirst(String query);

  Future<List<T>?> findAll(String query);

  Future<T?> put(T data);

  Future<T?> add(T data);

}
