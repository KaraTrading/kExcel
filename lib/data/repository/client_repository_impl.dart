import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/repository/client_repository.dart';

@Singleton(as: ClientRepository)
class ClientRepositoryImpl extends ClientRepository {

  @override
  Future<bool?> addClient(ClientEntity client) async {
    // TODO: implement addClient
    throw UnimplementedError();
  }

  @override
  Future<ClientEntity?> getClient(int id) async {
    // TODO: implement getClient
    throw UnimplementedError();
  }

  @override
  Future<List<ClientEntity>?> getClients({String? search}) async {
    // TODO: implement getClients
    throw UnimplementedError();
  }

}