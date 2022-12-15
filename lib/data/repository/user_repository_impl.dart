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
  Future<UserEntity?> getUser() {
    return userLocalDataSource.getUser();
  }

  @override
  Future<CompanyEntity> getUserCompany() async {
    final user = await getUser();
    return companyLocalDataSource.getUserCompany(user!.id!);
  }

  @override
  Future<bool?> saveUser(UserEntity entity) {
    return userLocalDataSource.setUser(entity);
  }

  @override
  Future<bool?> saveUserCompany(CompanyEntity entity) {
    return companyLocalDataSource.saveCompany(entity);
  }

}