import 'package:kexcel/data/datasource/base_local_data_source.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';

import '../../local/model/project_item_data.dart';

abstract class ProjectLocalDataSource extends BaseLocalDataSource<ProjectItemData> {

  Future<bool?> saveProjectItem(ProjectItemEntity projectItem);

  Future<bool?> updateProjectItem(ProjectItemEntity projectItem);

  Future<List<ProjectItemEntity>?> getProjectsItems(String? search);

  Future<ProjectItemEntity?> getProjectsItemsById(int id);

}
