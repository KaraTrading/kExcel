import 'attachment_entity.dart';
import 'base_entity.dart';
import 'project_entity.dart';
import 'project_item_entity.dart';
import 'supplier_entity.dart';

class EnvironmentEntity extends BaseEntity {
  ProjectEntity project;
  int id;
  int annualId;
  DateTime date;
  SupplierEntity? supplier;
  List<ProjectItemEntity>? items;
  List<AttachmentEntity>? attachments;

  EnvironmentEntity({
    required this.project,
    this.id = -1,
    this.annualId = -1,
    required this.date,
    this.supplier,
    this.items,
    this.attachments,
  });
}