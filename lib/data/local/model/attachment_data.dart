import 'package:hive/hive.dart';
import 'package:kexcel/data/local/database_configuration.dart';
import 'package:kexcel/data/local/model/base_data.dart';
import 'package:kexcel/domain/entity/attachment_entity.dart';
import 'package:kexcel/domain/entity/attachment_type.dart';

part 'attachment_data.g.dart';

@HiveType(typeId: attachmentTableTypeId)
class AttachmentData extends BaseData {

  @HiveField(1)
  String name;

  @HiveField(2)
  String filePath;

  @HiveField(3)
  AttachmentType type;

  AttachmentData({
    super.id = 0,
    required this.name,
    required this.filePath,
    required this.type,
  });
}

extension DataMapper on AttachmentData {
  AttachmentEntity get mapToEntity => AttachmentEntity(
    id: id,
    name: name,
    filePath: filePath,
    type: type,
  );
}

extension EntityMapper on AttachmentEntity {
  AttachmentData get mapToData => AttachmentData(
    id: id,
    name: name,
    filePath: filePath,
    type: type,
  );
}