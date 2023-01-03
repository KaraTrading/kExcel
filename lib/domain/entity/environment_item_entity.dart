import 'package:kexcel/domain/entity/base_entity.dart';
import 'package:kexcel/domain/entity/item_entity.dart';

class EnvironmentItemEntity extends BaseEntity {
  ItemEntity item;
  String? dimension;
  int quantity;

  EnvironmentItemEntity({
    required this.item,
    this.dimension,
    this.quantity = 1,
  });
}
