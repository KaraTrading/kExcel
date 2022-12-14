import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class ProjectItemBlocEvent extends BaseBlocEvent {}

class ProjectItemEventInit extends ProjectItemBlocEvent {
}
class ProjectItemEventSearch extends ProjectItemBlocEvent {
  final String? query;
  ProjectItemEventSearch(this.query);
}
class ProjectItemEventAddingDone extends ProjectItemBlocEvent {
  final ProjectItemEntity entity;
  ProjectItemEventAddingDone(this.entity);
}
class ProjectItemEventDelete extends ProjectItemBlocEvent {
  final ProjectItemEntity entity;
  ProjectItemEventDelete(this.entity);
}
class ProjectItemEventEditingDone extends ProjectItemBlocEvent {
  final ProjectItemEntity entity;
  ProjectItemEventEditingDone(this.entity);
}
class ProjectItemEventExport extends ProjectItemBlocEvent {}
class ProjectItemEventImport extends ProjectItemBlocEvent {
  final List<ProjectItemEntity> entities;
  ProjectItemEventImport(this.entities);
}