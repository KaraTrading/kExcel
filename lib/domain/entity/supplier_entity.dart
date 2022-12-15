import 'base_entity.dart';

class SupplierEntity extends BaseEntity {
  final int id;
  final String code;
  final String name;
  final String? address;
  final String? symbol;
  final String? vatId;
  final bool? isManufacturer;

  SupplierEntity({
    required this.id,
    required this.code,
    required this.name,
    this.address,
    this.symbol,
    this.vatId,
    this.isManufacturer,
  });
}
