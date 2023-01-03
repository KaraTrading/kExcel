import 'attachment_entity.dart';
import 'base_entity.dart';
import 'environment_item_entity.dart';
import 'client_entity.dart';
import 'supplier_entity.dart';

class EnvironmentEntity extends BaseEntity {
  int id;
  int projectId;
  String name;
  ClientEntity? client;
  SupplierEntity? supplier;
  List<EnvironmentItemEntity>? items;
  List<AttachmentEntity>? attachments;

  EnvironmentEntity({
    this.id = -1,
    required this.projectId,
    required this.name,
    this.client,
    this.supplier,
    this.items,
    this.attachments,
  });
}