import 'package:hive/hive.dart';
import 'package:kexcel/data/local/database_configuration.dart';
import 'package:kexcel/data/local/model/base_data.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
part 'project_data.g.dart';

@HiveType(typeId: projectTableTypeId)
class ProjectData extends BaseData {

  @HiveField(1)
  int annualId;

  @HiveField(2)
  int clientId;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  List<int> winnersIds;

  @HiveField(5)
  List<int> itemsIds;

  @HiveField(6)
  List<int> itemsQuantities;

  @HiveField(7)
  List<String?> itemsDimensions;

  @HiveField(8)
  List<int> enquiriesIds;

  @HiveField(9)
  List<int> attachmentsIds;

  ProjectData({
    super.id = 0,
    required this.annualId,
    required this.date,
    required this.clientId,
    this.winnersIds = const[],
    this.itemsIds = const[],
    this.itemsQuantities = const[],
    this.itemsDimensions = const[],
    this.enquiriesIds = const[],
    this.attachmentsIds = const[],
  });
}

extension DataMapper on ProjectData {
  ProjectEntity get mapToEntity => ProjectEntity(
    id: id,
    annualId: annualId,
    date: date,
    client: ClientEntity(id: -1, name: '', code: ''),
    winners: [],
    items: [],
    attachments: [],
    enquiriesIds: enquiriesIds,
  );
}

extension EntityMapper on ProjectEntity {
  ProjectData get mapToData => ProjectData(
    id: id,
    annualId: annualId,
    clientId: client.id,
    date: date,
    winnersIds: winners.map((e) => e.id).toList(),
    itemsIds: items.map((e) => e.item.id).toList(),
    itemsQuantities: items.map((e) => e.quantity).toList(),
    itemsDimensions: items.map((e) => e.dimension).toList(),
    enquiriesIds: enquiriesIds,
    attachmentsIds: attachments.map((e) => e.id).toList(),
  );
}