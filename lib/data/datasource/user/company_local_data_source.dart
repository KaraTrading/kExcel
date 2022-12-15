import 'package:kexcel/data/local/model/company_data.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import '../base_local_data_source.dart';

abstract class CompanyLocalDataSource extends BaseLocalDataSource<CompanyData> {

  Future<bool?> saveCompany(CompanyEntity entity);

  Future<bool?> updateCompany(CompanyEntity entity);

  Future<CompanyEntity> getUserCompany(int id);

  Future<List<CompanyEntity>> getCompanies();

}
