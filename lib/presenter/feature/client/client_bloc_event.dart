import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class ClientBlocEvent extends BaseBlocEvent {}

class ClientEventSearch extends ClientBlocEvent {
  final String? query;
  ClientEventSearch(this.query);
}

class ClientEventAddingNameChanged extends ClientBlocEvent {
  final String? name;
  ClientEventAddingNameChanged(this.name);
}

class ClientEventAddingDone extends ClientBlocEvent {}