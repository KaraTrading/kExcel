import 'package:injectable/injectable.dart';
import 'package:kexcel/data/local/model/item_data.dart';
import 'package:kexcel/data/local/model/supplier_data.dart';
import 'package:kexcel/data/local/database.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'item_local_data_source.dart';

@Injectable(as: ItemLocalDataSource)
class ItemLocalDataSourceImpl extends ItemLocalDataSource {

  Database<SupplierData> supplierStorage;

  @override
  Database<ItemData> storage;

  ItemLocalDataSourceImpl(this.storage, this.supplierStorage);

  @override
  Future<List<ItemEntity>?> getItems(String? search) async {
    final List<ItemData>? dataList;
    if (search == null || search.isEmpty) {
      dataList = await storage.getAll();
    } else {
      dataList = await storage.findAll(search);
    }
    final List<ItemEntity> list = [];
    dataList?.forEach((e) async {
      final item = await itemDataToItemEntity(e);
      if (item != null) {
        list.add(item);
      }
    });
    list.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return list;
  }

  @override
  Future<bool?> saveItem(ItemEntity client) async {
    final res = await storage.add(client.mapToData);
    return (res?.id ?? 0) > 0;
  }

  @override
  Future<bool?> deleteItem(ItemEntity client) async {
    return await storage.delete(client.mapToData);
  }

  @override
  Future<bool?> saveItems(List<ItemEntity> clients) async {
    await storage.deleteAll();
    bool allAdded = true;
    for (var element in clients) {
      final added = await saveItem(element);
      if (added!) allAdded = false;
    }
    return allAdded;
  }

  @override
  Future<bool?> updateItem(ItemEntity client) async {
    final res = await storage.put(client.mapToData);
    return (res?.id ?? 0) > 0;
  }

  @override
  Future<ItemEntity?> getItemById(int id) async {
    final data = await storage.getById(id);
    if (data != null) {
      return itemDataToItemEntity(data);
    } else {
      return null;
    }
  }

  Future<ItemEntity?> itemDataToItemEntity(ItemData data) async {
    final entity = data.mapToEntity;
    if (data.manufacturerId != null) {
      entity.manufacturer =
          (await supplierStorage.getById(data.manufacturerId!))?.mapToEntity;
    }
    return entity;
  }
}
