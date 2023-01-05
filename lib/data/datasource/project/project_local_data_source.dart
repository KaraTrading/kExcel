import 'package:kexcel/data/datasource/base_local_data_source.dart';
import 'package:kexcel/data/local/model/project_data.dart';
import 'package:kexcel/domain/entity/project_entity.dart';

abstract class ProjectLocalDataSource extends BaseLocalDataSource<ProjectData> {

  Future<int> saveProject(ProjectEntity entity);

  Future<bool?> saveProjects(List<ProjectEntity> entities);

  Future<bool?> deleteProject(ProjectEntity entity);

  Future<bool?> updateProject(ProjectEntity entity);

  Future<List<ProjectEntity>?> getProjects(String? search);

  Future<ProjectEntity?> getProject(int id);

  Future<int?> getLatestProjectAnnualId();

}
