import 'package:hive/hive.dart';
import 'package:kexcel/data/local/database_configuration.dart';
import 'package:kexcel/data/local/model/base_data.dart';
import 'package:kexcel/domain/entity/company_entity.dart';

part 'company_data.g.dart';

@HiveType(typeId: companyTableTypeId)
class CompanyData extends BaseData {

  @HiveField(1)
  String name;
  @HiveField(2)
  String logoAssetsAddress;
  @HiveField(3)
  String ceoName;
  @HiveField(4)
  String registerNumber;
  @HiveField(5)
  String taxNumber;
  @HiveField(6)
  String ustIdNumber;
  @HiveField(7)
  String email;
  @HiveField(8)
  String telephone;
  @HiveField(9)
  String? fax;
  @HiveField(10)
  String bankName;
  @HiveField(11)
  String bankIban;
  @HiveField(12)
  String bankBic;

  CompanyData({
    super.id = 0,
    required this.name,
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

extension CompanyDataMapper on CompanyData {
  CompanyEntity get mapToEntity => CompanyEntity(
    id: id,
    name: name,
    logoAssetsAddress: logoAssetsAddress,
    ceoName: ceoName,
    registerNumber: registerNumber,
    taxNumber: taxNumber,
    ustIdNumber: ustIdNumber,
    email: email,
    telephone: telephone,
    fax: fax,
    bankName: bankName,
    bankIban: bankIban,
    bankBic: bankBic,
  );
}

extension CompanyEntityMapper on CompanyEntity {
  CompanyData get mapToData => CompanyData(
      id: id,
      name: name,
      logoAssetsAddress: logoAssetsAddress,
      ceoName: ceoName,
      registerNumber: registerNumber,
      taxNumber: taxNumber,
      ustIdNumber: ustIdNumber,
      email: email,
      telephone: telephone,
      fax: fax,
      bankName: bankName,
      bankIban: bankIban,
      bankBic: bankBic,
  );
}