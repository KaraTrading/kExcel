import 'base_entity.dart';
import 'supplier_entity.dart';
import 'attachment_entity.dart';

class ItemEntity extends BaseEntity {
  final int id;
  final String name;
  final String? type;
  SupplierEntity? manufacturer;
  final String? description;
  final String? hsCode;
  List<AttachmentEntity>? attachments;

  ItemEntity({
    required this.id,
    required this.name,
    this.type,
    this.manufacturer,
    this.description,
    this.hsCode,
    this.attachments,
  });

  @override
  String toString() {
    return '$type: $name';
  }
}
