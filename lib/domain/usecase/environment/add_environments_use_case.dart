import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/environment_entity.dart';
import 'package:kexcel/domain/repository/environment_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class AddEnvironmentsUseCase extends BaseUseCase<bool, List<EnvironmentEntity>> {

  final EnvironmentRepository repository;

  AddEnvironmentsUseCase(this.repository);

  @override
  Future<bool> call(List<EnvironmentEntity> params) async {
    final bool? response = await repository.addEnvironments(params);
    return response == true;
  }

}