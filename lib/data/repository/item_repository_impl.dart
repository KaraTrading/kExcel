import 'package:injectable/injectable.dart';
import 'package:kexcel/data/datasource/item/item_local_data_source.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/repository/item_repository.dart';

@Injectable(as: ItemRepository)
class ItemRepositoryImpl extends ItemRepository {

  final ItemLocalDataSource localDataSource;
  ItemRepositoryImpl(this.localDataSource);

  @override
  Future<bool?> addItem(ItemEntity item) async {
    return await localDataSource.saveItem(item);
  }

  @override
  Future<bool?> deleteItem(ItemEntity item) async {
    return await localDataSource.deleteItem(item);
  }

  @override
  Future<bool?> addItems(List<ItemEntity> items) async {
    return await localDataSource.saveItems(items);
  }

  @override
  Future<bool?> updateItem(ItemEntity item) async {
    return await localDataSource.updateItem(item);
  }

  @override
  Future<ItemEntity?> getItem(int id) async {
    return await localDataSource.getItemById(id);
  }

  @override
  Future<List<ItemEntity>?> getItems({String? search}) async {
    return await localDataSource.getItems(search);
  }

}