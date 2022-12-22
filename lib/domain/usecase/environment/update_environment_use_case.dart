import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';
import '../../entity/environment_entity.dart';
import '../../repository/environment_repository.dart';

@Injectable()
class UpdateEnvironmentUseCase extends BaseUseCase<bool, EnvironmentEntity> {

  final EnvironmentRepository repository;

  UpdateEnvironmentUseCase(this.repository);

  @override
  Future<bool> call(EnvironmentEntity params) async {
    final bool? response = await repository.updateEnvironment(params);
    return response == true;
  }

}