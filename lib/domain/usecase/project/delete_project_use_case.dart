import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/domain/repository/project_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class DeleteProjectUseCase extends BaseUseCase<bool, ProjectEntity> {

  final ProjectRepository repository;

  DeleteProjectUseCase(this.repository);

  @override
  Future<bool> call(ProjectEntity params) async {
    final bool? response = await repository.deleteProject(params);
    return response == true;
  }

}