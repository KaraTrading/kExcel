import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/domain/repository/project_repository.dart';

@Singleton(as: ProjectRepository)
class ProjectRepositoryImpl extends ProjectRepository{
  @override
  Future<bool?> addProjectItem({required ProjectItemEntity projectItem}) async {
    // TODO: implement addProjectItem
    throw UnimplementedError();
  }

  @override
  Future<List<ProjectItemEntity>?> getProjectsItems({int? projectId, String? search}) async {
    // TODO: implement getProjectsItems
    throw UnimplementedError();
  }

}