import 'package:hive_flutter/hive_flutter.dart';
import 'package:kexcel/data/local/model/base_data.dart';
import 'package:kexcel/data/local/database.dart';

class DatabaseImpl<T extends BaseData> extends Database<T> {
  final Box<T> box;

  DatabaseImpl(this.box);

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
  Future<List<T>?> getByIds(List<int> ids) async {
    List<T> collected = [];
    for (var id in ids) {
      final item = box.get(id);
      if (item != null) {
        collected.add(item);
      }
    }
    return collected;
  }

  @override
  Future<T?> put(T data) async {
    box.put(data.id, data);
    return Future.value(data);
  }
  @override
  Future<int?> lastKey() async {
    final keys = box.keys;
    if (keys.isEmpty) {
      box.clear();
      return -1;
    }
    return keys.last;
  }
}
