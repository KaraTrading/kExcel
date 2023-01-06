import 'base_repository.dart';
import '../entity/enquiry_entity.dart';

abstract class EnquiryRepository extends BaseRepository {

  Future<List<EnquiryEntity>?> getEnquiries({
    int? projectId,
    String? search,
  });

  Future<EnquiryEntity?> getEnquiry(int id);

  Future<int> addEnquiry(EnquiryEntity entity);

  Future<bool?> addEnquiries(List<EnquiryEntity> entities);

  Future<bool?> deleteEnquiry(EnquiryEntity entity);

  Future<bool?> updateEnquiry(EnquiryEntity entity);
}
