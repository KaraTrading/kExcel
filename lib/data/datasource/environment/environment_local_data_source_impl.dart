import 'package:injectable/injectable.dart';
import 'package:kexcel/data/local/model/client_data.dart';
import 'package:kexcel/data/local/model/item_data.dart';
import 'package:kexcel/data/local/model/environment_data.dart';
import 'package:kexcel/data/local/model/supplier_data.dart';
import 'package:kexcel/data/local/database.dart';
import 'package:kexcel/domain/entity/environment_entity.dart';
import 'environment_local_data_source.dart';

@Injectable(as: EnvironmentLocalDataSource)
class ProjectLocalDataSourceImpl extends EnvironmentLocalDataSource {

  @override
  Database<EnvironmentData> storage;

  Database<ClientData> clientStorage;
  Database<SupplierData> supplierStorage;
  Database<ItemData> itemsStorage;

  ProjectLocalDataSourceImpl({
    required this.storage,
    required this.clientStorage,
    required this.supplierStorage,
    required this.itemsStorage,
  });

  @override
  Future<List<EnvironmentEntity>?> getEnvironments(String? search) async {
    final List<EnvironmentData>? data;
    if (search == null || search.isEmpty) {
      data = await storage.getAll();
    } else {
      data = await storage.findAll(search);
    }
    final List<EnvironmentEntity> all = [];

    if (data?.isEmpty ?? true) {
      return [];
    }
    for (var singleData in data!) {
      final item = await dataToEntity(singleData);
      if (item != null) {
        all.add(item);
      }
    }
    return all;
  }

  @override
  Future<bool?> saveEnvironment(EnvironmentEntity entity) async {
    final res = await storage.add(entity.mapToData);
    return (res?.id ?? 0) > 0;
  }

  @override
  Future<bool?> updateEnvironment(EnvironmentEntity entity) async {
    final res = await storage.put(entity.mapToData);
    return (res?.id ?? 0) > 0;
  }

  @override
  Future<EnvironmentEntity?> getEnvironment(int id) async {
    final data = await storage.getById(id);
    if (data != null) {
      return dataToEntity(data);
    } else {
      return null;
    }
  }

  Future<EnvironmentEntity?> dataToEntity(EnvironmentData data) async {
    final entity = data.mapToEntity;
    entity.client = (await clientStorage.getById(data.clientId))?.mapToEntity;
    if (data.supplierId != null) {
      entity.supplier =
          (await supplierStorage.getById(data.supplierId!))?.mapToEntity;
    }
    if (data.itemsIds != null) {
      entity.items = (await itemsStorage.getByIds(data.itemsIds!))?.map((e) => e.mapToEntity).toList() ?? [];
    }
    return entity;
  }

  @override
  Future<bool?> deleteEnvironment(EnvironmentEntity entity) async {
    return await storage.delete(entity.mapToData);
  }

  @override
  Future<bool?> saveEnvironments(List<EnvironmentEntity> entities) async {
    await storage.deleteAll();
    bool allAdded = true;
    for (var element in entities) {
      final added = await saveEnvironment(element);
      if (added!) allAdded = false;
    }
    return allAdded;
  }

  @override
  Future<int?> getLatestEnvironmentNumber() async {
    return storage.lastKey();
  }
}
