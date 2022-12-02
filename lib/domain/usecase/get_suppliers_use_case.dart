import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';
import '../repository/supplier_repository.dart';

@Singleton()
class GetSuppliersUseCase extends BaseUseCase<List<SupplierEntity>, String?> {

  final SupplierRepository repository;

  GetSuppliersUseCase(this.repository);

  @override
  Future<List<SupplierEntity>> call(String? params) async {
    final List<SupplierEntity>? response = await repository.getSuppliers(search: params);
    return response ?? [];
  }

}