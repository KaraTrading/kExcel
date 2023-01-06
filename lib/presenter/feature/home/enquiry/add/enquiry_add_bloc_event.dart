import 'package:kexcel/domain/entity/enquiry_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class EnquiryAddBlocEvent extends BaseBlocEvent {}

class EnquiryAddEventInit extends EnquiryAddBlocEvent {
  EnquiryEntity entity;
  EnquiryAddEventInit(this.entity);
}
class EnquiryAddEventAddingDone extends EnquiryAddBlocEvent {}