import 'package:injectable/injectable.dart';

import 'base_repository.dart';
import '../entity/supplier_entity.dart';

@Singleton()
abstract class SupplierRepository extends BaseRepository {

  Future<List<SupplierEntity>?> getSuppliers({String? search});

  Future<SupplierEntity?> getSupplier(int id);

  Future<bool?> addSupplier(SupplierEntity supplier);

}