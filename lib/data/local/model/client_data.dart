import 'package:hive/hive.dart';
import 'package:kexcel/data/local/model/base_data.dart';

part 'client_data.g.dart';

@HiveType(typeId: 0)
class ClientData extends BaseData {

  @HiveField(1)
  String name;

  ClientData({
    super.id = 0,
    required this.name,
  });
}