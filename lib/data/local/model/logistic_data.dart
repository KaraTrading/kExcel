import 'package:hive/hive.dart';
import 'package:kexcel/data/local/model/base_data.dart';
import 'package:kexcel/domain/entity/logistic_entity.dart';

part 'logistic_data.g.dart';

@HiveType(typeId: 2)
class LogisticData extends BaseData {

  @HiveField(1)
  String name;

  LogisticData({
    super.id = 0,
    required this.name,
  });
}

extension LogisticDataMapper on LogisticData {
  LogisticEntity get mapToEntity => LogisticEntity(id: id, name: name);
}

extension LogisticEntityMapper on LogisticEntity {
  LogisticData get mapToData => LogisticData(name: name);
}