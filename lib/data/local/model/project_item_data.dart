import 'package:hive/hive.dart';
import 'package:kexcel/data/local/database_configuration.dart';
import 'package:kexcel/data/local/model/base_data.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';

part 'project_item_data.g.dart';

@HiveType(typeId: projectsItemTableTypeId)
class ProjectItemData extends BaseData {
  @HiveField(1)
  int projectId;

  @HiveField(2)
  String name;

  @HiveField(3)
  int clientId;

  @HiveField(4)
  int karaProjectNumber;

  @HiveField(5)
  int? winnerId;

  @HiveField(6)
  int? logisticId;

  @HiveField(7)
  bool isCancelled;

  @HiveField(8)
  double? karaPiValue;

  @HiveField(9)
  DateTime? deliveryDate;

  @HiveField(10)
  List<int>? itemsIds;

  ProjectItemData({
    super.id = 0,
    required this.projectId,
    required this.name,
    required this.clientId,
    required this.karaProjectNumber,
    this.winnerId,
    this.logisticId,
    this.isCancelled = false,
    this.karaPiValue,
    this.deliveryDate,
    this.itemsIds,
  });
}

extension ProjectItemDataMapper on ProjectItemData {
  ProjectItemEntity get mapToEntity => ProjectItemEntity(
    projectId: projectId,
    id: id,
    name: name,
    client: null,
    karaProjectNumber: karaProjectNumber,
    winner: null,
    logisticEntity: null,
    isCancelled: isCancelled,
    karaPiValue: karaPiValue,
    deliveryDate: deliveryDate,
    items: null,
  );
}

extension ProjectItemEntityMapper on ProjectItemEntity {
  ProjectItemData get mapToData => ProjectItemData(
    projectId: projectId,
    name: name,
    clientId: client!.id,
    karaProjectNumber: karaProjectNumber,
    winnerId: winner?.id,
    logisticId: logisticEntity?.id,
    isCancelled: isCancelled,
    karaPiValue: karaPiValue,
    deliveryDate: deliveryDate,
    itemsIds: items?.map((e) => e.id).toList(),
  );
}