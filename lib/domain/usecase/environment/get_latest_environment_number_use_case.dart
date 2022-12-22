import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/repository/environment_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class GetLatestEnvironmentNumberUseCase extends BaseUseCase<int, void> {

  final EnvironmentRepository repository;

  GetLatestEnvironmentNumberUseCase(this.repository);

  @override
  Future<int> call(void params) async {
    final int? response = await repository.getLatestEnvironmentNumber();
    return response ?? -1;
  }

}