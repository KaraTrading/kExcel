import 'base_repository.dart';
import '../entity/project_item_entity.dart';

abstract class ProjectRepository extends BaseRepository {

  Future<List<ProjectItemEntity>?> getProjectsItems({
    int? projectId,
    String? search,
  });

  Future<ProjectItemEntity?> getProjectItem(int id);

  Future<bool?> addProjectItem({
    required ProjectItemEntity projectItem,
  });

  Future<bool?> updateProjectItem({
    required ProjectItemEntity projectItem,
  });
}
