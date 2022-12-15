import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/usecase/base_use_case.dart';
import '../../repository/supplier_repository.dart';

@Injectable()
class GetManufacturersUseCase extends BaseUseCase<List<SupplierEntity>, String?> {

  final SupplierRepository repository;

  GetManufacturersUseCase(this.repository);

  @override
  Future<List<SupplierEntity>> call(String? params) async {
    final List<SupplierEntity>? response = await repository.getManufacturers(search: params);
    return response ?? [];
  }

}