import 'package:hive/hive.dart';
import 'package:kexcel/data/local/model/base_data.dart';

part 'logistic_data.g.dart';

@HiveType(typeId: 0)
class LogisticData extends BaseData {

  @HiveField(1)
  String name;

  LogisticData({
    required this.name,
  });
}