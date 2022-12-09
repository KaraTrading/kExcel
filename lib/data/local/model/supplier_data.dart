import 'package:hive/hive.dart';
import 'package:kexcel/data/local/model/base_data.dart';

part 'supplier_data.g.dart';

@HiveType(typeId: 3)
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

  SupplierData({
    super.id = 0,
    required this.code,
    required this.name,
    this.address,
    this.symbol,
    this.vatId,
  });
}