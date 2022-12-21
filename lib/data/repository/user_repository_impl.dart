import 'package:injectable/injectable.dart';
import 'package:kexcel/data/datasource/user/company_local_data_source.dart';
import 'package:kexcel/data/datasource/user/user_local_data_source.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/domain/repository/user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl extends UserRepository {

  final UserLocalDataSource userLocalDataSource;
  final CompanyLocalDataSource companyLocalDataSource;

  UserRepositoryImpl(this.userLocalDataSource, this.companyLocalDataSource);

  @override
  Future<UserEntity?> getUser() async {
    return await userLocalDataSource.getUser();
  }

  @override
  Future<CompanyEntity> getUserCompany() async {
    final user = await getUser();
    return await companyLocalDataSource.getUserCompany(user?.id ?? 0); //TODO: Remove default after user bug fix
  }

  @override
  Future<List<CompanyEntity>> getCompanies() async {
    return await companyLocalDataSource.getCompanies();
  }

  @override
  Future<bool?> saveUser(UserEntity entity) async {
    return await userLocalDataSource.setUser(entity);
  }

  @override
  Future<bool?> saveUserCompany(CompanyEntity entity) async {
    return await companyLocalDataSource.saveCompany(entity);
  }

}