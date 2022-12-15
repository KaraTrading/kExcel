
import 'package:injectable/injectable.dart';
import 'package:kexcel/data/datasource/user/user_local_data_source.dart';
import 'package:kexcel/domain/entity/user_entity.dart';

@Injectable(as: UserLocalDataSource)
class UserLocalDataSourceImpl extends UserLocalDataSource {
  @override
  Future<UserEntity> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<bool?> setUser(UserEntity entity) {
    // TODO: implement setUser
    throw UnimplementedError();
  }

  @override
  Future<bool?> updateUser(UserEntity entity) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

}