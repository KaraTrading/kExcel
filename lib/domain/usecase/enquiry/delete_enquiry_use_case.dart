import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/enquiry_entity.dart';
import 'package:kexcel/domain/repository/enquiry_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class DeleteEnquiryUseCase extends BaseUseCase<bool, EnquiryEntity> {

  final EnquiryRepository repository;

  DeleteEnquiryUseCase(this.repository);

  @override
  Future<bool> call(EnquiryEntity params) async {
    final bool? response = await repository.deleteEnquiry(params);
    return response == true;
  }

}