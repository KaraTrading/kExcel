import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';
import '../../entity/enquiry_entity.dart';
import '../../repository/enquiry_repository.dart';

@Injectable()
class GetEnquiriesByProjectUseCase extends BaseUseCase<List<EnquiryEntity>, int> {

  final EnquiryRepository repository;

  GetEnquiriesByProjectUseCase(this.repository);

  @override
  Future<List<EnquiryEntity>> call(int params) async {
    final List<EnquiryEntity>? response = await repository.getEnquiries(projectId: params);
    return response ?? [];
  }

}