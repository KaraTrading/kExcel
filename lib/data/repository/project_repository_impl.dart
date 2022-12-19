import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/domain/repository/project_repository.dart';

import '../datasource/project/project_local_data_source.dart';

@Injectable(as: ProjectRepository)
class ProjectRepositoryImpl extends ProjectRepository{

  final ProjectLocalDataSource localDataSource;
  ProjectRepositoryImpl(this.localDataSource);

  @override
  Future<bool?> addProject(ProjectEntity entity) async {
    final res = localDataSource.saveProject(entity);
    return res;
  }

  @override
  Future<bool?> updateProject(ProjectEntity entity) async {
    final res = localDataSource.updateProject(entity);
    return res;
  }

  @override
  Future<ProjectEntity?> getProject(int id) async {
    final res = localDataSource.getProject(id);
    return res;
  }

  @override
  Future<List<ProjectEntity>?> getProjects({int? projectId, String? search}) async {
    final res = localDataSource.getProjects(search);
    return res;
  }

  @override
  Future<bool?> addProjects(List<ProjectEntity> entities) {
    final res = localDataSource.saveProjects(entities);
    return res;
  }

  @override
  Future<bool?> deleteProject(ProjectEntity entity) {
    final res = localDataSource.deleteProject(entity);
    return res;
  }

}