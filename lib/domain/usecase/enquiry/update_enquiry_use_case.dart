import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';
import '../../entity/enquiry_entity.dart';
import '../../repository/enquiry_repository.dart';

@Injectable()
class UpdateEnquiryUseCase extends BaseUseCase<bool, EnquiryEntity> {

  final EnquiryRepository repository;

  UpdateEnquiryUseCase(this.repository);

  @override
  Future<bool> call(EnquiryEntity params) async {
    final bool? response = await repository.updateEnquiry(params);
    return response == true;
  }

}