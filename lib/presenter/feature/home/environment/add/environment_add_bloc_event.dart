import 'package:kexcel/domain/entity/environment_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class EnvironmentAddBlocEvent extends BaseBlocEvent {}

class EnvironmentAddEventInit extends EnvironmentAddBlocEvent {
  EnvironmentEntity entity;
  EnvironmentAddEventInit(this.entity);
}
class EnvironmentAddEventAddingDone extends EnvironmentAddBlocEvent {}