import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';
import '../../entity/environment_entity.dart';
import '../../repository/environment_repository.dart';

@Injectable()
class GetEnvironmentsUseCase extends BaseUseCase<List<EnvironmentEntity>, String?> {

  final EnvironmentRepository repository;

  GetEnvironmentsUseCase(this.repository);

  @override
  Future<List<EnvironmentEntity>> call(String? params) async {
    final List<EnvironmentEntity>? response = await repository.getEnvironments(search: params);
    return response ?? [];
  }

}