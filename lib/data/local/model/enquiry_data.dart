import 'package:hive/hive.dart';
import 'package:kexcel/data/local/database_configuration.dart';
import 'package:kexcel/data/local/model/base_data.dart';
import 'package:kexcel/domain/entity/enquiry_entity.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
part 'enquiry_data.g.dart';

@HiveType(typeId: enquiryTableTypeId)
class EnquiryData extends BaseData {
  @HiveField(1)
  int projectId;

  @HiveField(2)
  int annualId;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  int? supplierId;

  @HiveField(5)
  List<int> itemsIds;

  @HiveField(6)
  List<int> attachmentsIds;

  EnquiryData({
    super.id = 0,
    required this.projectId,
    required this.annualId,
    required this.date,
    this.supplierId,
    this.itemsIds = const [],
    this.attachmentsIds = const [],
  });
}

extension DataMapper on EnquiryData {
  EnquiryEntity get mapToEntity => EnquiryEntity(
    project: ProjectEntity.empty(),
    id: id,
    annualId: annualId,
    date: date,
    attachments: [],
  );
}

extension EntityMapper on EnquiryEntity {
  EnquiryData get mapToData => EnquiryData(
    id: id,
    projectId: project.id,
    annualId: annualId,
    date: date,
    supplierId: supplier?.id,
    itemsIds: items.map((e) => e.item.id).toList(),
    attachmentsIds: attachments.map((e) => e.id).toList(),
  );
}