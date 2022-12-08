import 'package:hive_flutter/hive_flutter.dart';
import 'package:kexcel/data/local/model/base_data.dart';
import 'package:kexcel/data/local/secure_storage.dart';

class SecureStorageImpl<T extends BaseData> extends SecureStorage<T> {
  final Box<T> box;

  SecureStorageImpl(this.box);

  @override
  Future<T?> add(T data) async {
    final key = await box.add(data);
    data.id = key;
    await box.put(key, data);
    return Future.value(data);
  }

  @override
  Future<bool> delete(T data) async {
    box.delete(data.id);
    return Future.value(true);
  }

  @override
  Future<bool> deleteAll() async {
    box.clear();
    return Future.value(true);
  }

  @override
  Future<bool> deleteById(int id) async {
    box.delete(id);
    return Future.value(true);
  }

  @override
  Future<List<T>?> findAll(String query) async {
    final res = box
        .values
        .where((element) => element.toString().contains(query))
        .toList();
    return Future.value(res);
  }

  @override
  Future<T?> findFirst(String query) async {
    final res = box
        .values
        .firstWhere((element) => element.toString().contains(query));
    return Future.value(res);
  }

  @override
  Future<List<T>?> getAll() async {
    final res = box.values.toList();
    return Future.value(res);
  }

  @override
  Future<T?> getById(int id) async {
    final res = box.get(id);
    return Future.value(res);
  }

  @override
  Future<T?> put(T data) async {
    box.put(data.id, data);
    return Future.value(data);
  }
}
