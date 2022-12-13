import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/repository/item_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class AddItemsUseCase extends BaseUseCase<bool, List<ItemEntity>> {

  final ItemRepository repository;

  AddItemsUseCase(this.repository);

  @override
  Future<bool> call(List<ItemEntity> params) async {
    final bool? response = await repository.addItems(params);
    return response == true;
  }

}
