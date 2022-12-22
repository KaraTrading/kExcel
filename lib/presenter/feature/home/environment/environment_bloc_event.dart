import 'package:kexcel/domain/entity/environment_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class EnvironmentBlocEvent extends BaseBlocEvent {}

class EnvironmentEventInit extends EnvironmentBlocEvent {
}
class EnvironmentEventSearch extends EnvironmentBlocEvent {
  final String? query;
  EnvironmentEventSearch(this.query);
}
class EnvironmentEventAddingDone extends EnvironmentBlocEvent {
  final EnvironmentEntity entity;
  EnvironmentEventAddingDone(this.entity);
}
class EnvironmentEventDelete extends EnvironmentBlocEvent {
  final EnvironmentEntity entity;
  EnvironmentEventDelete(this.entity);
}
class EnvironmentEventEditingDone extends EnvironmentBlocEvent {
  final EnvironmentEntity entity;
  EnvironmentEventEditingDone(this.entity);
}
class EnvironmentEventExport extends EnvironmentBlocEvent {}
class EnvironmentEventImport extends EnvironmentBlocEvent {
  final List<EnvironmentEntity> entities;
  EnvironmentEventImport(this.entities);
}