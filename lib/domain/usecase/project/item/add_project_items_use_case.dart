import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/domain/repository/project_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class AddProjectItemsUseCase extends BaseUseCase<bool, List<ProjectItemEntity>> {

  final ProjectRepository repository;

  AddProjectItemsUseCase(this.repository);

  @override
  Future<bool> call(List<ProjectItemEntity> params) async {
    final bool? response = await repository.addProjectItems(params);
    return response == true;
  }

}