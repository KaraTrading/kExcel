import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';
import '../../repository/supplier_repository.dart';

@Injectable()
class DeleteSupplierUseCase extends BaseUseCase<bool, SupplierEntity> {

  final SupplierRepository repository;

  DeleteSupplierUseCase(this.repository);

  @override
  Future<bool> call(SupplierEntity params) async {
    final bool? response = await repository.deleteSupplier(params);
    return response == true;
  }

}