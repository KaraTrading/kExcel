import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';
import '../../repository/supplier_repository.dart';

@Injectable()
class AddSuppliersUseCase extends BaseUseCase<bool, List<SupplierEntity>> {

  final SupplierRepository repository;

  AddSuppliersUseCase(this.repository);

  @override
  Future<bool> call(List<SupplierEntity> params) async {
    final bool? response = await repository.addSuppliers(params);
    return response == true;
  }

}