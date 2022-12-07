import 'package:kexcel/domain/entity/supplier_entity.dart';
import '../../local/model/supplier_data.dart';
import '../base_local_data_source.dart';

abstract class SupplierLocalDataSource extends BaseLocalDataSource<SupplierData> {

  Future<bool?> saveSupplier(SupplierEntity supplier);

  Future<bool?> updateSupplier(SupplierEntity supplier);

  Future<SupplierEntity?> getSupplierById(int id);

  Future<List<SupplierEntity>?> getSuppliers(String? search);

}
