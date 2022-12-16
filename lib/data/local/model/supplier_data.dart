import 'package:hive/hive.dart';
import 'package:kexcel/data/local/database_configuration.dart';
import 'package:kexcel/data/local/model/base_data.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';

part 'supplier_data.g.dart';

@HiveType(typeId: supplierTableTypeId)
class SupplierData extends BaseData {

  @HiveField(1)
  String name;

  @HiveField(2)
  String? code;

  @HiveField(3)
  String? address;

  @HiveField(4)
  String? symbol;

  @HiveField(5)
  String? vatId;

  @HiveField(6)
  bool? isManufacturer;

  SupplierData({
    super.id = 0,
    required this.code,
    required this.name,
    this.address,
    this.symbol,
    this.vatId,
    this.isManufacturer,
  });
}

extension SupplierDataMapper on SupplierData {
  SupplierEntity get mapToEntity => SupplierEntity(
    id: id,
    code: code ?? '',
    name: name,
    address: address,
    symbol: symbol,
    vatId: vatId,
    isManufacturer: isManufacturer,
  );
}

extension SupplierEntityMapper on SupplierEntity {
  SupplierData get mapToData => SupplierData(
    id: id,
    code: code,
    name: name,
    address: address,
    symbol: symbol,
    vatId: vatId,
    isManufacturer: isManufacturer,
  );
}