import 'base_entity.dart';
import 'item_entity.dart';
import 'logistic_entity.dart';
import 'client_entity.dart';
import 'supplier_entity.dart';

class ProjectEntity extends BaseEntity {
  final int projectId;
  final int id;
  final String name;
  ClientEntity? client;
  final int karaProjectNumber;
  SupplierEntity? winner;
  LogisticEntity? logisticEntity;
  final bool isCancelled;
  final double? karaPiValue;
  final DateTime? deliveryDate;
  List<ItemEntity>? items;

  ProjectEntity({
    required this.projectId,
    required this.id,
    required this.name,
    this.client,
    required this.karaProjectNumber,
    this.winner,
    this.logisticEntity,
    this.karaPiValue,
    this.isCancelled = false,
    this.deliveryDate,
    this.items,
  });
}