import 'package:kexcel/domain/entity/base_entity.dart';

class CompanyEntity extends BaseEntity {
  final int id;
  final String name;
  final String? nameExtension;
  final String address;
  final String logoAssetsAddress;
  final String ceoName;
  final String registerNumber;
  final String taxNumber;
  final String ustIdNumber;
  final String email;
  final String telephone;
  final String? fax;
  final String bankName;
  final String bankIban;
  final String bankBic;

  CompanyEntity({
    required this.id,
    required this.name,
    this.nameExtension,
    required this.address,
    required this.logoAssetsAddress,
    required this.ceoName,
    required this.registerNumber,
    required this.taxNumber,
    required this.ustIdNumber,
    required this.email,
    required this.telephone,
    this.fax,
    required this.bankName,
    required this.bankIban,
    required this.bankBic,
  });
}
