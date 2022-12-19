import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class ProjectBlocEvent extends BaseBlocEvent {}

class ProjectEventInit extends ProjectBlocEvent {
}
class ProjectEventSearch extends ProjectBlocEvent {
  final String? query;
  ProjectEventSearch(this.query);
}
class ProjectEventAddingDone extends ProjectBlocEvent {
  final ProjectItemEntity entity;
  ProjectEventAddingDone(this.entity);
}
class ProjectEventDelete extends ProjectBlocEvent {
  final ProjectItemEntity entity;
  ProjectEventDelete(this.entity);
}
class ProjectEventEditingDone extends ProjectBlocEvent {
  final ProjectItemEntity entity;
  ProjectEventEditingDone(this.entity);
}
class ProjectEventExport extends ProjectBlocEvent {}
class ProjectEventImport extends ProjectBlocEvent {
  final List<ProjectItemEntity> entities;
  ProjectEventImport(this.entities);
}