import 'base_repository.dart';
import '../entity/project_item_entity.dart';

abstract class ProjectRepository extends BaseRepository {

  Future<List<ProjectItemEntity>?> getProjectsItems({
    int? projectId,
    String? search,
  });

  Future<ProjectItemEntity?> getProjectItem(int id);

  Future<bool?> addProjectItem(ProjectItemEntity entity);

  Future<bool?> addProjectItems(List<ProjectItemEntity> entities);

  Future<bool?> deleteProjectItem(ProjectItemEntity entity);

  Future<bool?> updateProjectItem(ProjectItemEntity entity);
}
