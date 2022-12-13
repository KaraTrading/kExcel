import 'package:injectable/injectable.dart';
import 'package:kexcel/data/datasource/supplier/supplier_local_data_source.dart';
import 'package:kexcel/data/local/model/supplier_data.dart';
import 'package:kexcel/data/local/secure_storage.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';

@Injectable(as: SupplierLocalDataSource)
class SupplierLocalDataSourceImpl extends SupplierLocalDataSource {

  @override
  SecureStorage<SupplierData> storage;

  SupplierLocalDataSourceImpl(this.storage);

  @override
  Future<SupplierEntity?> getSupplierById(int id) async {
    return (await storage.getById(id))?.mapToEntity;
  }

  @override
  Future<List<SupplierEntity>?> getSuppliers(String? search) async {
    if (search == null || search.isEmpty) {
      final allClientData = await storage.getAll();
      final allClientEntity = allClientData?.map((e) => e.mapToEntity).toList();
      return Future.value(allClientEntity);
    } else {
      final allClientData = await storage.findAll(search);
      final allClientEntity = allClientData?.map((e) => e.mapToEntity).toList();
      return Future.value(allClientEntity);
    }
  }

  @override
  Future<bool?> saveSupplier(SupplierEntity supplier) async {
    final res = storage.add(supplier.mapToData);
    return ((await res)?.id ?? 0) > 0;
  }


  @override
  Future<bool?> deleteSupplier(SupplierEntity supplier) async {
    final res = storage.delete(supplier.mapToData);
    return res;
  }

  @override
  Future<bool?> saveSuppliers(List<SupplierEntity> suppliers) async {
    await storage.deleteAll();
    bool allAdded = true;
    for (var element in suppliers) {
      final added = await saveSupplier(element);
      if (added!) allAdded = false;
    }
    return allAdded;
  }

  @override
  Future<bool?> updateSupplier(SupplierEntity supplier) async {
    final res = storage.put(supplier.mapToData);
    return ((await res)?.id ?? 0) > 0;
  }
}