import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';
import '../../../entity/project_item_entity.dart';
import '../../../repository/project_repository.dart';

@Injectable()
class AddProjectItemUseCase extends BaseUseCase<bool, ProjectItemEntity> {

  final ProjectRepository repository;

  AddProjectItemUseCase(this.repository);

  @override
  Future<bool> call(ProjectItemEntity params) async {
    final bool? response = await repository.addProjectItem(projectItem: params);
    return response == true;
  }

}