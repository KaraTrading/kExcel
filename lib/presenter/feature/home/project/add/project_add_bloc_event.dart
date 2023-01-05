import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class ProjectAddBlocEvent extends BaseBlocEvent {}

class ProjectAddEventInit extends ProjectAddBlocEvent {
  ProjectEntity? entity;
  ProjectAddEventInit(this.entity);
}
class ProjectAddEventAddingDone extends ProjectAddBlocEvent {
  ProjectAddEventAddingDone();
}