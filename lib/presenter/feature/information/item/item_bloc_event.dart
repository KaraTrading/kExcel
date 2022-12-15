import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class ItemBlocEvent extends BaseBlocEvent {}

class ItemEventInit extends ItemBlocEvent {
}
class ItemEventSearch extends ItemBlocEvent {
  final String? query;
  ItemEventSearch(this.query);
}
class ItemEventAddingDone extends ItemBlocEvent {
  final ItemEntity entity;
  ItemEventAddingDone(this.entity);
}
class ItemEventAddManufacturer extends ItemBlocEvent {
  final String manufacturerName;
  ItemEventAddManufacturer(this.manufacturerName);
}
class ItemEventDelete extends ItemBlocEvent {
  final ItemEntity entity;
  ItemEventDelete(this.entity);
}
class ItemEventEditingDone extends ItemBlocEvent {
  final ItemEntity entity;
  ItemEventEditingDone(this.entity);
}
class ItemEventExport extends ItemBlocEvent {}
class ItemEventImport extends ItemBlocEvent {
  final List<ItemEntity> entities;
  ItemEventImport(this.entities);
}