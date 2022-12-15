import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/repository/user_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class GetUserCompanyUseCase extends BaseUseCase<CompanyEntity, void> {

  final UserRepository repository;

  GetUserCompanyUseCase(this.repository);

  @override
  Future<CompanyEntity> call(void params) async {
    return await repository.getUserCompany();
  }

}