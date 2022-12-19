import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';
import '../../entity/project_item_entity.dart';
import '../../repository/project_repository.dart';

@Injectable()
class AddProjectUseCase extends BaseUseCase<bool, ProjectEntity> {

  final ProjectRepository repository;

  AddProjectUseCase(this.repository);

  @override
  Future<bool> call(ProjectEntity params) async {
    final bool? response = await repository.addProject(params);
    return response == true;
  }

}