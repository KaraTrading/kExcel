import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'base_repository.dart';

abstract class UserRepository extends BaseRepository {

  Future<UserEntity?> getUser();

  Future<bool?> saveUser(UserEntity entity);

  Future<CompanyEntity> getUserCompany();

  Future<List<CompanyEntity>> getCompanies();

  Future<bool?> saveUserCompany(CompanyEntity entity);

}