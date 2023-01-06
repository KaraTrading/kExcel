import 'package:injectable/injectable.dart';
import 'package:kexcel/data/datasource/enquiry/enquiry_local_data_source.dart';
import 'package:kexcel/data/datasource/project/project_local_data_source.dart';
import 'package:kexcel/domain/entity/enquiry_entity.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/domain/repository/enquiry_repository.dart';
import 'package:kexcel/domain/repository/project_repository.dart';


@Injectable(as: ProjectRepository)
class ProjectRepositoryImpl extends ProjectRepository{

  final ProjectLocalDataSource localDataSource;
  ProjectRepositoryImpl(this.localDataSource);

  @override
  Future<int> addProject(ProjectEntity entity) async {
    return await localDataSource.saveProject(entity);
  }

  @override
  Future<bool?> updateProject(ProjectEntity entity) async {
    return localDataSource.updateProject(entity);
  }

  @override
  Future<ProjectEntity?> getProject(int id) async {
    return localDataSource.getProject(id);
  }

  @override
  Future<List<ProjectEntity>?> getProjects({int? projectId, String? search}) async {
    return await localDataSource.getProjects(search);
  }

  @override
  Future<bool?> addProjects(List<ProjectEntity> entities) {
    return localDataSource.saveProjects(entities);
  }

  @override
  Future<bool?> deleteProject(ProjectEntity entity) {
    return localDataSource.deleteProject(entity);
  }

}