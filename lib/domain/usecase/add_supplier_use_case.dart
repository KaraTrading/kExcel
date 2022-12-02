import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';
import '../repository/supplier_repository.dart';

@Singleton()
class AddSupplierUseCase extends BaseUseCase<bool, SupplierEntity> {

  final SupplierRepository repository;

  AddSupplierUseCase(this.repository);

  @override
  Future<bool> call(SupplierEntity params) async {
    final bool? response = await repository.addSupplier(params);
    return response == true;
  }

}