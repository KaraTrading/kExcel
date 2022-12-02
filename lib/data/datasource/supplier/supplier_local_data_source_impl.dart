import 'package:kexcel/data/datasource/supplier/supplier_local_data_source.dart';
import 'package:kexcel/data/local/model/mapper.dart';
import 'package:kexcel/data/local/model/supplier_data.dart';
import 'package:kexcel/data/local/secure_storage.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';

class SupplierLocalDataSourceImpl extends SupplierLocalDataSource {

  @override
  SecureStorage<SupplierData> storage;

  SupplierLocalDataSourceImpl(this.storage) : super('suppliers');

  @override
  Future<SupplierEntity?> getSupplierById(int id) {
    // TODO: implement getSupplierById
    throw UnimplementedError();
  }

  @override
  Future<List<SupplierEntity>?> getSuppliers(String? search) {
    // TODO: implement getSuppliers
    throw UnimplementedError();
  }

  @override
  Future<bool?> saveSupplier(SupplierEntity supplier) async {
    final res = storage.add(supplier.mapToData);
    return ((await res)?.id ?? 0) > 0;
  }


}