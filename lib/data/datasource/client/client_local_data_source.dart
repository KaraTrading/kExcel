import 'package:injectable/injectable.dart';

import '../../../domain/entity/client_entity.dart';
import '../base_local_data_source.dart';

@Singleton()
abstract class ClientLocalDataSource extends BaseLocalDataSource {

  ClientLocalDataSource(super.tableName);

  Future<bool?> saveClient(ClientEntity client);

  Future<ClientEntity?> getClientById(int id);

  Future<List<ClientEntity>?> getClients(String? search);

}
