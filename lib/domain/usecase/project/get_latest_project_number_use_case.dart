import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/repository/project_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class GetLatestProjectNumberUseCase extends BaseUseCase<int, void> {

  final ProjectRepository repository;

  GetLatestProjectNumberUseCase(this.repository);

  @override
  Future<int> call(void params) async {
    final int? response = await repository.getLatestProjectNumber();
    return response ?? -1;
  }

}