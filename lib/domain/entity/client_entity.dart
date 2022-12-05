import 'base_entity.dart';

class ClientEntity extends BaseEntity {
  final int id;
  final String name;
  final String code;

  ClientEntity({
    required this.id,
    required this.name,
    required this.code,
  });
}
