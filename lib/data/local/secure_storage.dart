abstract class SecureStorage {
  Future<void> delete(String key);
  Future<void> deleteAll();
  Future<void> add(String key, String data);
  Future<void> put(String key, String data);
  Future<String?> get(String key);
}