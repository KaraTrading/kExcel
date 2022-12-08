import 'base_repository.dart';
import '../entity/client_entity.dart';

abstract class ClientRepository extends BaseRepository {

  Future<List<ClientEntity>?> getClients({String? search});

  Future<ClientEntity?> getClient(int id);

  Future<bool?> addClient(ClientEntity client);

  Future<bool?> addClients(List<ClientEntity> clients);

  Future<bool?> updateClient(ClientEntity client);

}