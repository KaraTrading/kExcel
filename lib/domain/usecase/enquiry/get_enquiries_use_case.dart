import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';
import '../../entity/enquiry_entity.dart';
import '../../repository/enquiry_repository.dart';

@Injectable()
class GetEnquiriesUseCase extends BaseUseCase<List<EnquiryEntity>, String?> {

  final EnquiryRepository repository;

  GetEnquiriesUseCase(this.repository);

  @override
  Future<List<EnquiryEntity>> call(String? params) async {
    final List<EnquiryEntity>? response = await repository.getEnquiries(search: params);
    return response ?? [];
  }

}