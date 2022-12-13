import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/repository/item_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';


@Injectable()
class DeleteItemUseCase extends BaseUseCase<bool, ItemEntity> {

  final ItemRepository repository;

  DeleteItemUseCase(this.repository);

  @override
  Future<bool> call(ItemEntity params) async {
    final bool? response = await repository.deleteItem(params);
    return response == true;
  }

}
