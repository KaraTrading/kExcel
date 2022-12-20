import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class ProjectItemAddBlocEvent extends BaseBlocEvent {}

class ProjectItemAddEventInit extends ProjectItemAddBlocEvent {}
class ProjectItemEventAddingDone extends ProjectItemAddBlocEvent {}