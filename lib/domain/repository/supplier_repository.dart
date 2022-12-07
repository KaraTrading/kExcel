import 'base_repository.dart';
import '../entity/supplier_entity.dart';

abstract class SupplierRepository extends BaseRepository {

  Future<List<SupplierEntity>?> getSuppliers({String? search});

  Future<SupplierEntity?> getSupplier(int id);

  Future<bool?> addSupplier(SupplierEntity supplier);

  Future<bool?> updateSupplier(SupplierEntity supplier);

}