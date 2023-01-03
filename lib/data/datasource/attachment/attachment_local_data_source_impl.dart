import 'package:injectable/injectable.dart';
import 'package:kexcel/data/local/model/attachment_data.dart';
import 'package:kexcel/data/local/database.dart';
import 'package:kexcel/domain/entity/attachment_entity.dart';
import 'attachment_local_data_source.dart';

@Injectable(as: AttachmentLocalDataSource)
class AttachmentLocalDataSourceImpl extends AttachmentLocalDataSource {

  @override
  Database<AttachmentData> storage;

  AttachmentLocalDataSourceImpl(this.storage);

  @override
  Future<AttachmentEntity?> getAttachmentById(int id) async {
    return (await storage.getById(id))?.mapToEntity;
  }

  @override
  Future<List<AttachmentEntity>?> getAttachments(String? search) async {
    if (search == null || search.isEmpty) {
      final allClientData = await storage.getAll();
      final allClientEntity = allClientData?.map((e) => e.mapToEntity).toList();
      return Future.value(allClientEntity);
    } else {
      final allClientData = await storage.findAll(search);
      final allClientEntity = allClientData?.map((e) => e.mapToEntity).toList();
      return Future.value(allClientEntity);
    }
  }

  @override
  Future<bool?> saveAttachment(AttachmentEntity item) async {
    final res = await storage.add(item.mapToData);
    return (res?.id ?? 0) > 0;
  }


  @override
  Future<bool?> deleteAttachment(AttachmentEntity item) async {
    return await storage.delete(item.mapToData);
  }

  @override
  Future<bool?> saveAttachments(List<AttachmentEntity> items) async {
    await storage.deleteAll();
    bool allAdded = true;
    for (var element in items) {
      final added = await saveAttachment(element);
      if (added!) allAdded = false;
    }
    return allAdded;
  }

  @override
  Future<bool?> updateAttachment(AttachmentEntity item) async {
    final res = await storage.put(item.mapToData);
    return (res?.id ?? 0) > 0;
  }
}