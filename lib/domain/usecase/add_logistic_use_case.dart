import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

import '../entity/logistic_entity.dart';
import '../repository/logistic_repository.dart';

@Injectable()
class AddLogisticUseCase extends BaseUseCase<bool, LogisticEntity> {

  final LogisticRepository repository;

  AddLogisticUseCase(this.repository);

  @override
  Future<bool> call(LogisticEntity params) async {
    final bool? response = await repository.addLogistic(params);
    return response == true;
  }

}
