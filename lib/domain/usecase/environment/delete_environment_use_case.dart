import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/environment_entity.dart';
import 'package:kexcel/domain/repository/environment_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class DeleteEnvironmentUseCase extends BaseUseCase<bool, EnvironmentEntity> {

  final EnvironmentRepository repository;

  DeleteEnvironmentUseCase(this.repository);

  @override
  Future<bool> call(EnvironmentEntity params) async {
    final bool? response = await repository.deleteEnvironment(params);
    return response == true;
  }

}