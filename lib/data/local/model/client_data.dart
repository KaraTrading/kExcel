import 'package:hive/hive.dart';
import 'package:kexcel/data/local/model/base_data.dart';

part 'client_data.g.dart';

@HiveType(typeId: 1)
class ClientData extends BaseData {

  @HiveField(1)
  String code;
  @HiveField(2)
  String name;
  @HiveField(3)
  String? address;
  @HiveField(4)
  String? nationalId;
  @HiveField(5)
  String? symbol;
  @HiveField(6)
  String? bafaId;
  @HiveField(7)
  String? bafaEmail;
  @HiveField(8)
  String? bafaSite;
  @HiveField(9)
  String? contact;
  @HiveField(10)
  String? bank;

  ClientData({
    super.id = 0,
    required this.code,
    required this.name,
    this.address,
    this.nationalId,
    this.symbol,
    this.bafaId,
    this.bafaEmail,
    this.bafaSite,
    this.contact,
    this.bank,
  });
}