import 'package:kexcel/domain/entity/enquiry_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class EnquiryBlocEvent extends BaseBlocEvent {}

class EnquiryEventInit extends EnquiryBlocEvent {
}
class EnquiryEventSearch extends EnquiryBlocEvent {
  final String? query;
  EnquiryEventSearch(this.query);
}
class EnquiryEventAddingDone extends EnquiryBlocEvent {
  final EnquiryEntity entity;
  EnquiryEventAddingDone(this.entity);
}
class EnquiryEventDelete extends EnquiryBlocEvent {
  final EnquiryEntity entity;
  EnquiryEventDelete(this.entity);
}
class EnquiryEventEditingDone extends EnquiryBlocEvent {
  final EnquiryEntity entity;
  EnquiryEventEditingDone(this.entity);
}
class EnquiryEventExport extends EnquiryBlocEvent {}
class EnquiryEventImport extends EnquiryBlocEvent {
  final List<EnquiryEntity> entities;
  EnquiryEventImport(this.entities);
}