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
    final userMobile = await secureStorage.get(userMobileKey);
    final userCompanyId = await secureStorage.get(userCompanyIdKey);

    if (userId != null &&
        userName != null &&
        userTitle != null &&
        userEmail != null &&
        userCompanyId != null) {
      return UserEntity(
        id: int.tryParse(userId) ?? 0,
        name: userName,
        title: userTitle,
        email: userEmail,
        mobile: userMobile,
        companyId: int.tryParse(userCompanyId) ?? 0,
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
    await secureStorage.add(userMobileKey, entity.mobile ?? '');
    await secureStorage.add(userCompanyIdKey, entity.companyId.toString());
    return true;
  }

  @override
  Future<bool?> updateUser(UserEntity entity) async {
    await secureStorage.put(userIdKey, (entity.id ?? 0).toString());
    await secureStorage.put(userNameKey, entity.name);
    await secureStorage.put(userTitleKey, entity.title);
    await secureStorage.put(userEmailKey, entity.email);
    await secureStorage.put(userMobileKey, entity.mobile ?? '');
    await secureStorage.put(userCompanyIdKey, entity.companyId.toString());
    return true;
  }

  @override
  Future<void> logout() async {
    await secureStorage.delete(userIdKey);
    await secureStorage.delete(userNameKey);
    await secureStorage.delete(userTitleKey);
    await secureStorage.delete(userEmailKey);
    await secureStorage.delete(userMobileKey);
    await secureStorage.delete(userCompanyIdKey);
    return Future(() => null);
  }
}
