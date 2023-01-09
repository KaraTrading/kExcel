import 'package:injectable/injectable.dart';
import 'package:kexcel/data/datasource/enquiry/enquiry_local_data_source.dart';
import 'package:kexcel/domain/entity/enquiry_entity.dart';
import 'package:kexcel/domain/repository/enquiry_repository.dart';


@Injectable(as: EnquiryRepository)
class EnquiryRepositoryImpl extends EnquiryRepository{

  final EnquiryLocalDataSource localDataSource;
  EnquiryRepositoryImpl(this.localDataSource);

  @override
  Future<int> addEnquiry(EnquiryEntity entity) async {
    return await localDataSource.saveEnquiry(entity);
  }

  @override
  Future<bool?> updateEnquiry(EnquiryEntity entity) async {
    return localDataSource.updateEnquiry(entity);
  }

  @override
  Future<EnquiryEntity?> getEnquiry(int id) async {
    return localDataSource.getEnquiry(id);
  }

  @override
  Future<List<EnquiryEntity>?> getEnquiries({int? projectId, String? search}) async {
    return await localDataSource.getEnquiries(projectId: projectId, search: search);
  }

  @override
  Future<bool?> addEnquiries(List<EnquiryEntity> entities) {
    return localDataSource.saveEnquiries(entities);
  }

  @override
  Future<bool?> deleteEnquiry(EnquiryEntity entity) {
    return localDataSource.deleteEnquiry(entity);
  }

}