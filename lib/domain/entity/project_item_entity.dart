import 'package:kexcel/domain/entity/base_entity.dart';
import 'package:kexcel/domain/entity/item_entity.dart';

class ProjectItemEntity extends BaseEntity {
  ItemEntity item;
  String? dimension;
  int quantity;

  ProjectItemEntity({
    required this.item,
    this.dimension,
    this.quantity = 1,
  });

  @override
  String toString() {
    return item.toString();
  }
}
