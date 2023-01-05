import 'package:kexcel/domain/entity/attachment_entity.dart';

import 'base_entity.dart';
import 'project_item_entity.dart';
import 'client_entity.dart';
import 'supplier_entity.dart';

class ProjectEntity extends BaseEntity {
  int id;
  int annualId;
  ClientEntity client;
  DateTime date;
  List<SupplierEntity> winners;
  List<ProjectItemEntity> items;
  List<AttachmentEntity> attachments;

  ProjectEntity({
    this.id = -1,
    required this.annualId,
    required this.client,
    required this.date,
    this.winners = const [],
    this.items = const [],
    this.attachments = const [],
  });

  ProjectEntity.empty()
      : id = -1,
        annualId = 0,
        client = ClientEntity.empty(),
        date = DateTime.now(),
        winners = const [],
        items = const [],
        attachments = const [];
}