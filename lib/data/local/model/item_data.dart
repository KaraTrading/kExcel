import 'package:hive/hive.dart';
import 'package:kexcel/data/local/model/base_data.dart';
import 'package:kexcel/domain/entity/item_entity.dart';

part 'item_data.g.dart';

@HiveType(typeId: 4)
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

  ItemData({
    super.id = 0,
    required this.name,
    this.type,
    this.manufacturerId,
    this.description,
    this.hsCode,
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
  );
}