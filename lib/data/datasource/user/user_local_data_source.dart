import 'package:kexcel/domain/entity/user_entity.dart';

abstract class UserLocalDataSource {

  Future<bool?> setUser(UserEntity entity);

  Future<bool?> updateUser(UserEntity entity);

  Future<UserEntity?> getUser();

}
