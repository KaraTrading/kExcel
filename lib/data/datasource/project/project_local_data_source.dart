import 'package:injectable/injectable.dart';
import 'package:kexcel/data/datasource/base_local_data_source.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';

@Singleton()
abstract class ProjectLocalDataSource extends BaseLocalDataSource {
  ProjectLocalDataSource(super.tableName);

  Future<bool?> saveProjectItem(ProjectItemEntity projectItem);

  Future<List<ProjectItemEntity>?> getProjectsItems(String? search);

  Future<ProjectItemEntity?> getProjectsItemsById(int id);

}
