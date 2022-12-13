import 'package:kexcel/data/local/model/item_data.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import '../base_local_data_source.dart';

abstract class ItemLocalDataSource extends BaseLocalDataSource<ItemData> {

  Future<bool?> saveItem(ItemEntity client);

  Future<bool?> deleteItem(ItemEntity client);

  Future<bool?> saveItems(List<ItemEntity> clients);

  Future<bool?> updateItem(ItemEntity client);

  Future<ItemEntity?> getItemById(int id);

  Future<List<ItemEntity>?> getItems(String? search);
}
