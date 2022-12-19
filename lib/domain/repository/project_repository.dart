import 'base_repository.dart';
import '../entity/project_item_entity.dart';

abstract class ProjectRepository extends BaseRepository {

  Future<List<ProjectEntity>?> getProjects({
    int? projectId,
    String? search,
  });

  Future<ProjectEntity?> getProject(int id);

  Future<bool?> addProject(ProjectEntity entity);

  Future<bool?> addProjects(List<ProjectEntity> entities);

  Future<bool?> deleteProject(ProjectEntity entity);

  Future<bool?> updateProject(ProjectEntity entity);
}
