import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/repository/client_repository.dart';

import '../datasource/client/client_local_data_source.dart';

@Injectable(as: ClientRepository)
class ClientRepositoryImpl extends ClientRepository {

  final ClientLocalDataSource localDataSource;
  ClientRepositoryImpl(this.localDataSource);

  @override
  Future<bool?> addClient(ClientEntity client) async {
    return await localDataSource.saveClient(client);
  }

  @override
  Future<bool?> deleteClient(ClientEntity client) async {
    return await localDataSource.deleteClient(client);
  }

  @override
  Future<bool?> addClients(List<ClientEntity> clients) async {
    return await localDataSource.saveClients(clients);
  }

  @override
  Future<bool?> updateClient(ClientEntity client) async {
    return await localDataSource.updateClient(client);
  }

  @override
  Future<ClientEntity?> getClient(int id) async {
    return await localDataSource.getClientById(id);
  }

  @override
  Future<List<ClientEntity>?> getClients({String? search}) async {
    return await localDataSource.getClients(search);
  }

}