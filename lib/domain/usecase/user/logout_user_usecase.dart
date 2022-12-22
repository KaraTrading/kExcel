import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/domain/repository/user_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class LogoutUserUseCase extends BaseUseCase<void, void> {

  final UserRepository repository;

  LogoutUserUseCase(this.repository);

  @override
  Future<void> call(void params) async {
    return await repository.logout();
  }

}