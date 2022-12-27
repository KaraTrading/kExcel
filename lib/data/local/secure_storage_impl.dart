import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kexcel/data/local/secure_storage.dart';

class SecureStorageImpl extends SecureStorage {
  final FlutterSecureStorage secureStorage;
  SecureStorageImpl(this.secureStorage);

  @override
  Future<void> add(String key, String data) async {
    debugPrint('----------\nvalue before write: ${await get(key)}');
    debugPrint('trying to write: $data');
    await secureStorage.write(key: key, value: data);
    debugPrint('value after wrote: ${await get(key)}\n----------');
  }

  @override
  Future<void> delete(String key) async {
    return await secureStorage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    return await secureStorage.deleteAll();
  }

  @override
  Future<String?> get(String key) async {
    return await secureStorage.read(key: key);
  }

  @override
  Future<void> put(String key, String data) async {
    debugPrint('----------\nvalue before write: ${await get(key)}');
    debugPrint('trying to write: $data');
    await secureStorage.delete(key: key);
    await secureStorage.write(key: key, value: data);
    debugPrint('value after wrote: ${await get(key)}\n----------');
  }
}