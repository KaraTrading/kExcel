import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

import '../../repository/client_repository.dart';

@Injectable()
class AddClientsUseCase extends BaseUseCase<bool, List<ClientEntity>> {

  final ClientRepository repository;

  AddClientsUseCase(this.repository);

  @override
  Future<bool> call(List<ClientEntity> params) async {
    final bool? response = await repository.addClients(params);
    return response == true;
  }

}
