import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

import '../repository/client_repository.dart';

@Singleton()
class GetClientsUseCase extends BaseUseCase<List<ClientEntity>, String?> {

  final ClientRepository repository;

  GetClientsUseCase(this.repository);

  @override
  Future<List<ClientEntity>> call(String? params) async {
    final List<ClientEntity>? response = await repository.getClients(search: params);
    return response ?? [];
  }

}