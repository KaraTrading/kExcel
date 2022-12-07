import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class ClientBlocEvent extends BaseBlocEvent {}

class ClientEventInit extends ClientBlocEvent {
}
class ClientEventSearch extends ClientBlocEvent {
  final String? query;
  ClientEventSearch(this.query);
}
class ClientEventAddingDone extends ClientBlocEvent {
  final ClientEntity client;
  ClientEventAddingDone(this.client);
}
class ClientEventEditingDone extends ClientBlocEvent {
  final ClientEntity client;
  ClientEventEditingDone(this.client);
}