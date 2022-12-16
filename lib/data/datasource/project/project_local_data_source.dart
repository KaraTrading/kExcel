import 'package:kexcel/data/datasource/base_local_data_source.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';

import '../../local/model/project_item_data.dart';

abstract class ProjectLocalDataSource extends BaseLocalDataSource<ProjectItemData> {

  Future<bool?> saveProjectItem(ProjectItemEntity entity);

  Future<bool?> saveProjectItems(List<ProjectItemEntity> entities);

  Future<bool?> deleteProjectItem(ProjectItemEntity entity);

  Future<bool?> updateProjectItem(ProjectItemEntity entity);

  Future<List<ProjectItemEntity>?> getProjectsItems(String? search);

  Future<ProjectItemEntity?> getProjectsItemsById(int id);

}
