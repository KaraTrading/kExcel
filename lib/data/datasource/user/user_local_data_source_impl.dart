import 'package:injectable/injectable.dart';
import 'package:kexcel/data/datasource/user/user_local_data_source.dart';
import 'package:kexcel/data/local/secure_storage.dart';
import 'package:kexcel/data/local/secure_storage_configuration.dart';
import 'package:kexcel/domain/entity/user_entity.dart';

@Injectable(as: UserLocalDataSource)
class UserLocalDataSourceImpl extends UserLocalDataSource {
  final SecureStorage secureStorage;

  UserLocalDataSourceImpl(this.secureStorage);

  @override
  Future<UserEntity?> getUser() async {
    final userId = await secureStorage.get(userIdKey);
    final userName = await secureStorage.get(userNameKey);
    final userTitle = await secureStorage.get(userTitleKey);
    final userEmail = await secureStorage.get(userEmailKey);
    final userCompanyId = await secureStorage.get(userCompanyIdKey);

    if (userId != null &&
        userName != null &&
        userTitle != null &&
        userEmail != null &&
        userCompanyId != null) {
      return UserEntity(
        id: userId as int,
        name: userName,
        title: userTitle,
        email: userEmail,
        companyId: userCompanyId as int,
      );
    }
    return null;
  }

  @override
  Future<bool?> setUser(UserEntity entity) async {
    await secureStorage.add(userIdKey, (entity.id ?? 0).toString());
    await secureStorage.add(userNameKey, entity.name);
    await secureStorage.add(userTitleKey, entity.title);
    await secureStorage.add(userEmailKey, entity.email);
    await secureStorage.add(userCompanyIdKey, entity.companyId.toString());
    return true;
  }

  @override
  Future<bool?> updateUser(UserEntity entity) async {
    return await setUser(entity);
  }
}
