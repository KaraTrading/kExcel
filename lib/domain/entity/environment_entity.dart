import 'base_entity.dart';
import 'item_entity.dart';
import 'client_entity.dart';
import 'supplier_entity.dart';

class EnvironmentEntity extends BaseEntity {
  final int projectId;
  final int id;
  String name;
  ClientEntity? client;
  SupplierEntity? supplier;
  List<ItemEntity>? items;

  EnvironmentEntity({
    required this.projectId,
    required this.id,
    required this.name,
    this.client,
    this.supplier,
    this.items,
  });
}