import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

import '../entity/logistic_entity.dart';
import '../repository/logistic_repository.dart';

@Injectable()
class GetLogisticsUseCase extends BaseUseCase<List<LogisticEntity>, String?> {

  final LogisticRepository repository;

  GetLogisticsUseCase(this.repository);

  @override
  Future<List<LogisticEntity>> call(String? params) async {
    final List<LogisticEntity>? response = await repository.getLogistics(search: params);
    return response ?? [];
  }

}