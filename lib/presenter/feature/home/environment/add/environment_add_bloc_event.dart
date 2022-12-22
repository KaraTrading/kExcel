import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class EnvironmentAddBlocEvent extends BaseBlocEvent {}

class EnvironmentAddEventInit extends EnvironmentAddBlocEvent {}
class EnvironmentAddEventUpdatedProject extends EnvironmentAddBlocEvent {}
class EnvironmentAddEventAddingDone extends EnvironmentAddBlocEvent {}