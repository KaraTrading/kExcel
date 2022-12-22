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
  final ClientEntity entity;
  ClientEventAddingDone(this.entity);
}
class ClientEventDelete extends ClientBlocEvent {
  final ClientEntity entity;
  ClientEventDelete(this.entity);
}
class ClientEventEditingDone extends ClientBlocEvent {
  final ClientEntity entity;
  ClientEventEditingDone(this.entity);
}
class ClientEventExport extends ClientBlocEvent {}
class ClientEventImport extends ClientBlocEvent {
  final List<ClientEntity> entities;
  ClientEventImport(this.entities);
}