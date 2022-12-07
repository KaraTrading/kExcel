import 'package:hive/hive.dart';
import 'package:kexcel/data/local/model/base_data.dart';

part 'supplier_data.g.dart';

@HiveType(typeId: 3)
class SupplierData extends BaseData {

  @HiveField(1)
  String name;

  SupplierData({
    super.id = 0,
    required this.name,
  });
}