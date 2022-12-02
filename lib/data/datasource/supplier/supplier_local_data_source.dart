import 'package:injectable/injectable.dart';

import '../../../domain/entity/supplier_entity.dart';
import '../base_local_data_source.dart';

@Singleton()
abstract class SupplierLocalDataSource extends BaseLocalDataSource {

  SupplierLocalDataSource(super.tableName);

  Future<bool?> saveSupplier(SupplierEntity supplier);

  Future<SupplierEntity?> getSupplierById(int id);

  Future<List<SupplierEntity>?> getSuppliers(String? search);

}
