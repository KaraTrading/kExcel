import 'package:kexcel/domain/entity/item_entity.dart';

import 'base_repository.dart';

abstract class ItemRepository extends BaseRepository {

  Future<List<ItemEntity>?> getItems({String? search});

  Future<ItemEntity?> getItem(int id);

  Future<bool?> addItem(ItemEntity item);

  Future<bool?> deleteItem(ItemEntity item);

  Future<bool?> addItems(List<ItemEntity> items);

  Future<bool?> updateItem(ItemEntity item);

}