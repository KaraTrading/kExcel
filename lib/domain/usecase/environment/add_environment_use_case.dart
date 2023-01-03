import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';
import '../../entity/environment_entity.dart';
import '../../repository/environment_repository.dart';

@Injectable()
class AddEnvironmentUseCase extends BaseUseCase<int, EnvironmentEntity> {

  final EnvironmentRepository repository;

  AddEnvironmentUseCase(this.repository);

  @override
  Future<int> call(EnvironmentEntity params) async {
    return (await repository.addEnvironment(params)) ?? -1;
  }
}