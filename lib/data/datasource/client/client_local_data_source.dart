import '../../../domain/entity/client_entity.dart';
import '../../local/model/client_data.dart';
import '../base_local_data_source.dart';

abstract class ClientLocalDataSource extends BaseLocalDataSource<ClientData> {

  Future<bool?> saveClient(ClientEntity client);

  Future<ClientEntity?> getClientById(int id);

  Future<List<ClientEntity>?> getClients(String? search);
}
