import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

import '../../entity/item_entity.dart';
import '../../repository/item_repository.dart';

@Injectable()
class AddItemUseCase extends BaseUseCase<bool, ItemEntity> {

  final ItemRepository repository;

  AddItemUseCase(this.repository);

  @override
  Future<bool> call(ItemEntity params) async {
    final bool? response = await repository.addItem(params);
    return response == true;
  }

}
