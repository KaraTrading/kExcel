import 'package:kexcel/domain/entity/base_entity.dart';

class UserEntity extends BaseEntity {
  final int? id;
  final String name;
  final String title;
  final String email;

  UserEntity({
    this.id,
    required this.name,
    required this.title,
    required this.email,
  });
}
