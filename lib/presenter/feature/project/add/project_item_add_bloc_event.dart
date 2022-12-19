import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class ProjectItemAddBlocEvent extends BaseBlocEvent {}

class ProjectItemAddEventInit extends ProjectItemAddBlocEvent {}
class ProjectItemEventAddingDone extends ProjectItemAddBlocEvent {
  final ProjectEntity entity;
  ProjectItemEventAddingDone(this.entity);
}