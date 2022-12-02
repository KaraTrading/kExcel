import 'package:injectable/injectable.dart';

import 'base_repository.dart';
import '../entity/client_entity.dart';

@Singleton()
abstract class ClientRepository extends BaseRepository {

  Future<List<ClientEntity>?> getClients({String? search});

  Future<ClientEntity?> getClient(int id);

  Future<bool?> addClient(ClientEntity client);

}