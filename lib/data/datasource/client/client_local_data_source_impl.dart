import 'package:injectable/injectable.dart';
import 'package:kexcel/data/datasource/client/client_local_data_source.dart';
import 'package:kexcel/data/local/model/client_data.dart';
import 'package:kexcel/data/local/model/mapper.dart';
import 'package:kexcel/data/local/secure_storage.dart';
import 'package:kexcel/domain/entity/client_entity.dart';

@Injectable(as: ClientLocalDataSource)
class ClientLocalDataSourceImpl extends ClientLocalDataSource {

  @override
  SecureStorage<ClientData> storage;

  ClientLocalDataSourceImpl(this.storage);

  @override
  Future<List<ClientEntity>?> getClients(String? search) async {
    if (search == null || search.isEmpty) {
      final allClientData = await storage.getAll();
      final allClientEntity = allClientData?.map((e) => e.mapToEntity).toList();
      return Future.value(allClientEntity);
    } else {
      final allClientData = await storage.findAll(search);
      final allClientEntity = allClientData?.map((e) => e.mapToEntity).toList();
      return Future.value(allClientEntity);
    }
  }

  @override
  Future<bool?> saveClient(ClientEntity client) async {
    final res = storage.add(client.mapToData);
    return ((await res)?.id ?? 0) > 0;
  }

  @override
  Future<ClientEntity?> getClientById(int id) async {
    return (await storage.getById(id))?.mapToEntity;
  }
}
