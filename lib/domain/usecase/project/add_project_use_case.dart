import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/domain/repository/project_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class AddProjectUseCase extends BaseUseCase<int, ProjectEntity> {

  final ProjectRepository repository;

  AddProjectUseCase(this.repository);

  @override
  Future<int> call(ProjectEntity params) async {
    return await repository.addProject(params);
  }
}