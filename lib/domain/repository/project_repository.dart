import 'package:kexcel/domain/entity/project_entity.dart';
import 'base_repository.dart';

abstract class ProjectRepository extends BaseRepository {

  Future<List<ProjectEntity>?> getProjects({
    int? projectId,
    String? search,
  });

  Future<ProjectEntity?> getProject(int id);

  Future<int> addProject(ProjectEntity entity);

  Future<bool?> addProjects(List<ProjectEntity> entities);

  Future<bool?> deleteProject(ProjectEntity entity);

  Future<bool?> updateProject(ProjectEntity entity);

  Future<int?> getLatestProjectNumber();
}
