import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/repository/item_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class GetItemsUseCase extends BaseUseCase<List<ItemEntity>, String?> {

  final ItemRepository repository;

  GetItemsUseCase(this.repository);

  @override
  Future<List<ItemEntity>> call(String? params) async {
    final List<ItemEntity>? response = await repository.getItems(search: params);
    return response ?? [];
  }

}