import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class ProjectBlocEvent extends BaseBlocEvent {}

class ProjectEventInit extends ProjectBlocEvent {
}
class ProjectEventSearch extends ProjectBlocEvent {
  final String? query;
  ProjectEventSearch(this.query);
}
class ProjectEventDelete extends ProjectBlocEvent {
  final ProjectEntity entity;
  ProjectEventDelete(this.entity);
}
class ProjectEventExport extends ProjectBlocEvent {}
class ProjectEventImport extends ProjectBlocEvent {
  final List<ProjectEntity> entities;
  ProjectEventImport(this.entities);
}