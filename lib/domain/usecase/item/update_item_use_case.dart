import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/repository/item_repository.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';

@Injectable()
class UpdateItemUseCase extends BaseUseCase<bool, ItemEntity> {

  final ItemRepository repository;

  UpdateItemUseCase(this.repository);

  @override
  Future<bool> call(ItemEntity params) async {
    final bool? response = await repository.updateItem(params);
    return response == true;
  }

}
