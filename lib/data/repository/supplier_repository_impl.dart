import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/repository/supplier_repository.dart';

import '../datasource/supplier/supplier_local_data_source.dart';

@Injectable(as: SupplierRepository)
class SupplierRepositoryImpl extends SupplierRepository {

  final SupplierLocalDataSource localDataSource;

  SupplierRepositoryImpl(this.localDataSource);

  @override
  Future<bool?> addSupplier(SupplierEntity supplier) async {
    final res = localDataSource.saveSupplier(supplier);
    return res;
  }
  @override
  Future<bool?> addSuppliers(List<SupplierEntity> suppliers) async {
    final res = localDataSource.saveSuppliers(suppliers);
    return res;
  }
  @override
  Future<bool?> deleteSupplier(SupplierEntity supplier) async {
    final res = localDataSource.deleteSupplier(supplier);
    return res;
  }

  @override
  Future<bool?> updateSupplier(SupplierEntity supplier) async {
    final res = localDataSource.updateSupplier(supplier);
    return res;
  }

  @override
  Future<SupplierEntity?> getSupplier(int id) async {
    final res = localDataSource.getSupplierById(id);
    return res;
  }

  @override
  Future<List<SupplierEntity>?> getSuppliers({String? search}) async {
    final res = localDataSource.getSuppliers(search);
    return res;
  }

  @override
  Future<List<SupplierEntity>?> getManufacturers({String? search}) async {
    final res = localDataSource.getManufacturers(search);
    return res;
  }

}