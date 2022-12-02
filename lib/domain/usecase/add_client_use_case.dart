import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

import '../repository/client_repository.dart';

@Singleton()
class AddClientUseCase extends BaseUseCase<bool, ClientEntity> {

  final ClientRepository repository;

  AddClientUseCase(this.repository);

  @override
  Future<bool> call(ClientEntity params) async {
    final bool? response = await repository.addClient(params);
    return response == true;
  }

}
