import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/domain/repository/project_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class AddProjectsUseCase extends BaseUseCase<bool, List<ProjectEntity>> {

  final ProjectRepository repository;

  AddProjectsUseCase(this.repository);

  @override
  Future<bool> call(List<ProjectEntity> params) async {
    final bool? response = await repository.addProjects(params);
    return response == true;
  }

}