import 'package:injectable/injectable.dart';

import 'base_repository.dart';
import '../entity/project_item_entity.dart';

@Singleton()
abstract class ProjectRepository extends BaseRepository {

  Future<List<ProjectItemEntity>?> getProjectsItems({
    int? projectId,
    String? search,
  });

  Future<bool?> addProjectItem({
    required ProjectItemEntity projectItem,
  });
}
