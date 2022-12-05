import 'package:hive_flutter/hive_flutter.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/data/local/model/base_data.dart';
import 'package:kexcel/data/local/secure_storage.dart';

class SecureStorageImpl<T extends BaseData> extends SecureStorage<T> {
  final String tableName;

  SecureStorageImpl(this.tableName) {
    checkTable();
  }

  @override
  Future<T?> add(T data) async {
    Hive.box<T>(tableName).add(data);
    data.id = data.key;
    Hive.box(tableName).putAt(data.key, data);
    return Future.value(data);
  }

  @override
  Future<bool> delete(T data) async {
    Hive.box<T>(tableName).delete(data.id);
    return Future.value(true);
  }

  @override
  Future<bool> deleteById(int id) async {
    Hive.box<T>(tableName).delete(id);
    return Future.value(true);
  }

  @override
  Future<List<T>?> findAll(String query) async {
    final res = Hive.box<T>(tableName)
        .values
        .where((element) => element.toString().contains(query))
        .toList();
    return Future.value(res);
  }

  @override
  Future<T?> findFirst(String query) async {
    final res = Hive.box<T>(tableName)
        .values
        .firstWhere((element) => element.toString().contains(query));
    return Future.value(res);
  }

  @override
  Future<List<T>?> getAll() async {
    final res = Hive.box<T>(tableName).values.toList();
    return Future.value(res);
  }

  @override
  Future<T?> getById(int id) async {
    final res = Hive.box<T>(tableName).get(id);
    return Future.value(res);
  }

  @override
  Future<T?> put(T data) async {
    Hive.box<T>(tableName).put(data.id, data);
    return Future.value(data);
  }

  void checkTable() async {
    try {
      await Hive.openBox<T>(tableName);
    } on BaseException {

    }
  }
}
