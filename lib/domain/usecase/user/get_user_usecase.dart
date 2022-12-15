import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/domain/repository/user_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class GetUserUseCase extends BaseUseCase<UserEntity?, void> {

  final UserRepository repository;

  GetUserUseCase(this.repository);

  @override
  Future<UserEntity?> call(void params) async {
    return await repository.getUser();
  }

}