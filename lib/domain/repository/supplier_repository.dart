import 'base_repository.dart';
import '../entity/supplier_entity.dart';

abstract class SupplierRepository extends BaseRepository {

  Future<List<SupplierEntity>?> getSuppliers({String? search});

  Future<List<SupplierEntity>?> getManufacturers({String? search});

  Future<SupplierEntity?> getSupplier(int id);

  Future<bool?> addSupplier(SupplierEntity supplier);

  Future<bool?> addSuppliers(List<SupplierEntity> suppliers);

  Future<bool?> updateSupplier(SupplierEntity supplier);

  Future<bool?> deleteSupplier(SupplierEntity supplier);

}