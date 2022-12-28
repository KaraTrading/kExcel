import 'base_entity.dart';
import 'item_entity.dart';
import 'client_entity.dart';
import 'supplier_entity.dart';

class EnvironmentEntity extends BaseEntity {
  final int id;
  int projectId;
  String name;
  ClientEntity? client;
  SupplierEntity? supplier;
  List<ItemEntity>? items;

  EnvironmentEntity({
    this.id = -1,
    required this.projectId,
    required this.name,
    this.client,
    this.supplier,
    this.items,
  });
}