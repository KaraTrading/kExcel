import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/repository/user_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class GetCompaniesUseCase extends BaseUseCase<List<CompanyEntity>, void> {

  final UserRepository repository;

  GetCompaniesUseCase(this.repository);

  @override
  Future<List<CompanyEntity>> call(void params) async {
    return await repository.getCompanies();
  }

}