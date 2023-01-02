import 'package:hive/hive.dart';
import 'package:kexcel/data/local/database_configuration.dart';
import 'package:kexcel/data/local/model/base_data.dart';
import 'package:kexcel/domain/entity/item_entity.dart';

part 'item_data.g.dart';

@HiveType(typeId: itemTableTypeId)
class ItemData extends BaseData {

  @HiveField(1)
  String name;

  @HiveField(2)
  String? type;

  @HiveField(3)
  int? manufacturerId;

  @HiveField(4)
  String? description;

  @HiveField(5)
  String? hsCode;

  @HiveField(6)
  List<int>? attachmentsIds;

  ItemData({
    super.id = 0,
    required this.name,
    this.type,
    this.manufacturerId,
    this.description,
    this.hsCode,
    this.attachmentsIds,
  });
}

extension ProjectItemDataMapper on ItemData {
  ItemEntity get mapToEntity => ItemEntity(
    id: id,
    name: name,
    type: type,
    manufacturer: null,
    description: description,
    hsCode: hsCode,
    attachments: null,
  );
}

extension ItemEntityMapper on ItemEntity {
  ItemData get mapToData => ItemData(
    id: id,
    name: name,
    type: type,
    manufacturerId: manufacturer != null ? manufacturer!.id : null,
    description: description,
    hsCode: hsCode,
    attachmentsIds: attachments?.map((e) => e.id).toList(),
  );
}