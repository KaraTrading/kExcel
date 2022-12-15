import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/domain/repository/project_repository.dart';

import '../datasource/project/project_local_data_source.dart';

@Injectable(as: ProjectRepository)
class ProjectRepositoryImpl extends ProjectRepository{

  final ProjectLocalDataSource localDataSource;
  ProjectRepositoryImpl(this.localDataSource);

  @override
  Future<bool?> addProjectItem(ProjectItemEntity entity) async {
    final res = localDataSource.saveProjectItem(entity);
    return res;
  }

  @override
  Future<bool?> updateProjectItem(ProjectItemEntity entity) async {
    final res = localDataSource.updateProjectItem(entity);
    return res;
  }

  @override
  Future<ProjectItemEntity?> getProjectItem(int id) async {
    final res = localDataSource.getProjectsItemsById(id);
    return res;
  }

  @override
  Future<List<ProjectItemEntity>?> getProjectsItems({int? projectId, String? search}) async {
    final res = localDataSource.getProjectsItems(search);
    return res;
  }

  @override
  Future<bool?> addProjectItems(List<ProjectItemEntity> entities) {
    final res = localDataSource.saveProjectItems(entities);
    return res;
  }

  @override
  Future<bool?> deleteProjectItem(ProjectItemEntity entity) {
    final res = localDataSource.deleteProjectItem(entity);
    return res;
  }

}