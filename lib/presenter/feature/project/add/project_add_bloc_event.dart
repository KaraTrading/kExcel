import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class ProjectAddBlocEvent extends BaseBlocEvent {}

class ProjectAddEventInit extends ProjectAddBlocEvent {}
class ProjectAddEventUpdatedProject extends ProjectAddBlocEvent {}
class ProjectAddEventAddingDone extends ProjectAddBlocEvent {}