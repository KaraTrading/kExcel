import 'package:hive/hive.dart';
import 'package:kexcel/data/local/model/base_data.dart';

part 'project_item_data.g.dart';

@HiveType(typeId: 0)
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
  });
}