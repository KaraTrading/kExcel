import 'package:injectable/injectable.dart';
import 'package:kexcel/data/local/model/company_data.dart';
import 'package:kexcel/data/local/secure_storage.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'company_local_data_source.dart';

@Injectable(as: CompanyLocalDataSource)
class CompanyLocalDataSourceImpl extends CompanyLocalDataSource {

  @override
  SecureStorage<CompanyData> storage;

  CompanyLocalDataSourceImpl(this.storage);

  @override
  Future<CompanyEntity> getUserCompany(int id) async {
    return (await storage.getById(id))!.mapToEntity;
  }

  @override
  Future<List<CompanyEntity>> getCompanies() async {
      return Future.value((await storage.getAll())!.map((e) => e.mapToEntity).toList());
  }

  @override
  Future<bool?> updateCompany(CompanyEntity entity) async {
    final res = storage.put(entity.mapToData);
    return ((await res)?.id ?? 0) > 0;
  }

  @override
  Future<bool?> saveCompany(CompanyEntity entity) async {
    final res = storage.add(entity.mapToData);
    return ((await res)?.id ?? 0) > 0;
  }
}