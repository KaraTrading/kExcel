import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';
import '../../entity/project_item_entity.dart';
import '../../repository/project_repository.dart';

@Injectable()
class GetProjectsUseCase extends BaseUseCase<List<ProjectEntity>, String?> {

  final ProjectRepository repository;

  GetProjectsUseCase(this.repository);

  @override
  Future<List<ProjectEntity>> call(String? params) async {
    final List<ProjectEntity>? response = await repository.getProjects(search: params);
    return response ?? [];
  }

}