import 'package:kexcel/domain/entity/base_entity.dart';

import 'supplier_entity.dart';

class ItemEntity extends BaseEntity {
  final int id;
  final String name;
  final String? type;
  SupplierEntity? manufacturer;
  final String? description;
  final String? hsCode;

  ItemEntity({
    required this.id,
    required this.name,
    this.type,
    this.manufacturer,
    this.description,
    this.hsCode,
  });

  @override
  String toString() {
    return '$name $type';
  }
}
