import 'package:kexcel/data/datasource/base_local_data_source.dart';
import 'package:kexcel/domain/entity/enquiry_entity.dart';

import '../../local/model/enquiry_data.dart';

abstract class EnquiryLocalDataSource extends BaseLocalDataSource<EnquiryData> {

  Future<int> saveEnquiry(EnquiryEntity entity);

  Future<bool?> saveEnquiries(List<EnquiryEntity> entities);

  Future<bool?> deleteEnquiry(EnquiryEntity entity);

  Future<bool?> updateEnquiry(EnquiryEntity entity);

  Future<List<EnquiryEntity>?> getEnquiries({int? projectId, String? search});

  Future<EnquiryEntity?> getEnquiry(int id);

}
