import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class SupplierBlocEvent extends BaseBlocEvent {}

class SupplierEventInit extends SupplierBlocEvent {
}
class SupplierEventSearch extends SupplierBlocEvent {
  final String? query;
  SupplierEventSearch(this.query);
}
class SupplierEventAddingDone extends SupplierBlocEvent {
  final SupplierEntity entity;
  SupplierEventAddingDone(this.entity);
}
class SupplierEventDelete extends SupplierBlocEvent {
  final SupplierEntity entity;
  SupplierEventDelete(this.entity);
}
class SupplierEventEditingDone extends SupplierBlocEvent {
  final SupplierEntity entity;
  SupplierEventEditingDone(this.entity);
}
class SupplierEventExport extends SupplierBlocEvent {}
class SupplierEventImport extends SupplierBlocEvent {
  final List<SupplierEntity> entities;
  SupplierEventImport(this.entities);
}