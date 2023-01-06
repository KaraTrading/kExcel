import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/enquiry_entity.dart';
import 'package:kexcel/domain/repository/enquiry_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class AddEnquiriesUseCase extends BaseUseCase<bool, List<EnquiryEntity>> {

  final EnquiryRepository repository;

  AddEnquiriesUseCase(this.repository);

  @override
  Future<bool> call(List<EnquiryEntity> params) async {
    final bool? response = await repository.addEnquiries(params);
    return response == true;
  }

}