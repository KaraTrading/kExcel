import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/domain/repository/user_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class UpdateUserUseCase extends BaseUseCase<bool, UserEntity> {

  final UserRepository repository;

  UpdateUserUseCase(this.repository);

  @override
  Future<bool> call(UserEntity params) async {
    final res = await repository.updateUser(params);
    return res == true;
  }

}