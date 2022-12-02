import 'package:kexcel/domain/entity/supplier_entity.dart';
import '../base_local_data_source.dart';

abstract class SupplierLocalDataSource<T> extends BaseLocalDataSource<T> {

  Future<bool?> saveSupplier(SupplierEntity supplier);

  Future<SupplierEntity?> getSupplierById(int id);

  Future<List<SupplierEntity>?> getSuppliers(String? search);

}
