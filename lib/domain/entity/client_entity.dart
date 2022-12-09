import 'base_entity.dart';

class ClientEntity extends BaseEntity {
  final int id;
  final String name;
  final String code;
  final String? address;
  final String? nationalId;
  final String? symbol;
  final String? bafaId;
  final String? bafaEmail;
  final String? bafaSite;
  final String? contact;
  final String? bank;

  ClientEntity({
    required this.id,
    required this.name,
    required this.code,
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
