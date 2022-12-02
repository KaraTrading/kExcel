import '../../../domain/entity/client_entity.dart';
import '../base_local_data_source.dart';

abstract class ClientLocalDataSource<T> extends BaseLocalDataSource<T> {

  Future<bool?> saveClient(ClientEntity client);

  Future<ClientEntity?> getClientById(int id);

  Future<List<ClientEntity>?> getClients(String? search);
}
