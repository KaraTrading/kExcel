import 'package:hive/hive.dart';
import 'package:kexcel/data/local/database_configuration.dart';
import 'package:kexcel/data/local/model/base_data.dart';
import 'package:kexcel/domain/entity/environment_entity.dart';

part 'environment_data.g.dart';

@HiveType(typeId: environmentTableTypeId)
class EnvironmentData extends BaseData {
  @HiveField(1)
  int projectId;

  @HiveField(2)
  String name;

  @HiveField(3)
  int clientId;

  @HiveField(4)
  int? supplierId;

  @HiveField(5)
  List<int>? itemsIds;

  EnvironmentData({
    super.id = 0,
    required this.projectId,
    required this.name,
    required this.clientId,
    this.supplierId,
    this.itemsIds,
  });
}

extension DataMapper on EnvironmentData {
  EnvironmentEntity get mapToEntity => EnvironmentEntity(
    projectId: projectId,
    id: id,
    name: name,
    client: null,
    supplier: null,
    items: null,
  );
}

extension EntityMapper on EnvironmentEntity {
  EnvironmentData get mapToData => EnvironmentData(
    id: id,
    projectId: projectId,
    name: name,
    clientId: client!.id,
    supplierId: supplier?.id,
    itemsIds: items?.map((e) => e.id).toList(),
  );
}