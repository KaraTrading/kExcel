import 'package:kexcel/domain/entity/attachment_type.dart';
import 'package:kexcel/domain/entity/base_entity.dart';

class AttachmentEntity extends BaseEntity {
  final int id;
  final String name;
  final String filePath;
  final AttachmentType type;

  AttachmentEntity({
    required this.id,
    required this.name,
    required this.filePath,
    required this.type,
  });
}
