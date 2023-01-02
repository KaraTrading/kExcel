import 'package:kexcel/data/local/model/attachment_data.dart';
import 'package:kexcel/domain/entity/attachment_entity.dart';
import '../base_local_data_source.dart';

abstract class AttachmentLocalDataSource extends BaseLocalDataSource<AttachmentData> {

  Future<bool?> saveAttachment(AttachmentEntity item);

  Future<bool?> saveAttachments(List<AttachmentEntity> items);

  Future<bool?> deleteAttachment(AttachmentEntity item);

  Future<bool?> updateAttachment(AttachmentEntity item);

  Future<AttachmentEntity?> getAttachmentById(int id);

  Future<List<AttachmentEntity>?> getAttachments(String? search);

}
