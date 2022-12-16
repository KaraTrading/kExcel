import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/domain/repository/user_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class SetUserUseCase extends BaseUseCase<bool, UserEntity> {

  final UserRepository repository;

  SetUserUseCase(this.repository);

  @override
  Future<bool> call(UserEntity params) async {
    final res = await repository.saveUser(params);
    return res == true;
  }

}