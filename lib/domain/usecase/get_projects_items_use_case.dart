import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';
import '../entity/project_item_entity.dart';
import '../repository/project_repository.dart';

@Injectable()
class GetProjectItemsUseCase extends BaseUseCase<List<ProjectItemEntity>, String?> {

  final ProjectRepository repository;

  GetProjectItemsUseCase(this.repository);

  @override
  Future<List<ProjectItemEntity>> call(String? params) async {
    final List<ProjectItemEntity>? response = await repository.getProjectsItems(search: params);
    return response ?? [];
  }

}