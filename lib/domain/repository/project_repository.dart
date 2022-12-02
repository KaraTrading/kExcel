import 'base_repository.dart';
import '../entity/project_item_entity.dart';

abstract class ProjectRepository extends BaseRepository {

  Future<List<ProjectItemEntity>?> getProjectsItems({
    int? projectId,
    String? search,
  });

  Future<bool?> addProjectItem({
    required ProjectItemEntity projectItem,
  });
}
