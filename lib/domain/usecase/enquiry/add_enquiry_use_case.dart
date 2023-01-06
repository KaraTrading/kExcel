import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';
import '../../entity/enquiry_entity.dart';
import '../../repository/enquiry_repository.dart';

@Injectable()
class AddEnquiryUseCase extends BaseUseCase<int, EnquiryEntity> {

  final EnquiryRepository repository;

  AddEnquiryUseCase(this.repository);

  @override
  Future<int> call(EnquiryEntity params) async {
    return (await repository.addEnquiry(params)) ?? -1;
  }
}