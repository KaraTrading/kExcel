import 'package:injectable/injectable.dart';
import 'package:kexcel/data/local/model/company_data.dart';
import 'package:kexcel/data/local/database.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'company_local_data_source.dart';

@Injectable(as: CompanyLocalDataSource)
class CompanyLocalDataSourceImpl extends CompanyLocalDataSource {

  @override
  Database<CompanyData> storage;

  CompanyLocalDataSourceImpl(this.storage);

  @override
  Future<CompanyEntity> getUserCompany(int id) async {
    return (await storage.getById(id))!.mapToEntity;
  }

  @override
  Future<List<CompanyEntity>> getCompanies() async {
    final companies = await storage.getAll() ?? [];
    if (companies.isNotEmpty) {
      return (companies).map((e) => e.mapToEntity).toList();
    } else {
      await saveCompany(CompanyEntity(id: 0, name: 'Metpool', logoAssetsAddress: 'assets/images/metpool_logo.png', ceoName: 'Amin Katani', registerNumber: '90875', taxNumber: '103/5746/3762', ustIdNumber: 'DE-336448399', email: 'info@metpool.de', telephone: '+492115229548', fax: '+49211522954899', bankName: 'Stadtsparkasse', bankIban: 'DE73 3005 0110 1008 3759 80', bankBic: 'DUSSDEDDXXX'));
      await saveCompany(CompanyEntity(id: 1, name: 'Kara', logoAssetsAddress: 'assets/images/kara_logo.png', ceoName: 'Ahmad Katani', registerNumber: '73611', taxNumber: '103/5739/1683', ustIdNumber: 'DE-297826287', email: 'info@kara-trading.de', telephone: '+4921152295480', fax: '+49211522954899', bankName: 'Stadtsparkasse', bankIban: 'DE05 3005 0110 1007 0354 03', bankBic: 'DUSSDEDDXXX'));
      return await getCompanies();
    }
  }

  @override
  Future<bool?> updateCompany(CompanyEntity entity) async {
    final res = await storage.put(entity.mapToData);
    return (res?.id ?? 0) > 0;
  }

  @override
  Future<bool?> saveCompany(CompanyEntity entity) async {
    final res = await storage.add(entity.mapToData);
    return (res?.id ?? 0) > 0;
  }
}