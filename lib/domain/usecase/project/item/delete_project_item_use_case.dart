import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/domain/repository/project_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class DeleteProjectItemUseCase extends BaseUseCase<bool, ProjectItemEntity> {

  final ProjectRepository repository;

  DeleteProjectItemUseCase(this.repository);

  @override
  Future<bool> call(ProjectItemEntity params) async {
    final bool? response = await repository.deleteProjectItem(params);
    return response == true;
  }

}