import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/enquiry_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/usecase/enquiry/add_enquiry_use_case.dart';
import 'package:kexcel/domain/usecase/enquiry/add_enquiries_use_case.dart';
import 'package:kexcel/domain/usecase/enquiry/delete_enquiry_use_case.dart';
import 'package:kexcel/domain/usecase/enquiry/get_enquiries_use_case.dart';
import 'package:kexcel/domain/usecase/enquiry/update_enquiry_use_case.dart';
import 'package:kexcel/domain/usecase/supplier/get_suppliers_use_case.dart';
import 'package:kexcel/domain/usecase/user/get_user_company_usecase.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';
import 'enquiry_bloc_event.dart';

@Singleton()
class EnquiryBloc extends BaseBloc<EnquiryBlocEvent> {
  EnquiryBloc() {
    on<EnquiryEventInit>(_getAll);
    on<EnquiryEventSearch>(_getAll);
    on<EnquiryEventAddingDone>(_addNew);
    on<EnquiryEventEditingDone>(_update);
    on<EnquiryEventImport>(_importNewItems);
    on<EnquiryEventDelete>(_delete);
  }

  late CompanyEntity company;
  late List<SupplierEntity> suppliers = [];
  late List<EnquiryEntity> enquiries = [];

  _getAll(event, emit) async {
    try {
      emit(LoadingState());

      company = await dependencyResolver<GetUserCompanyUseCase>().call(null);

      if (suppliers.isEmpty) {
        suppliers = await dependencyResolver<GetSuppliersUseCase>().call(null);
      }

      enquiries = await dependencyResolver<GetEnquiriesUseCase>()
          .call(event is EnquiryEventSearch ? event.query : null);
      emit(ResponseState<List<EnquiryEntity>>(data: enquiries));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }

  _addNew(EnquiryEventAddingDone event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      await dependencyResolver<AddEnquiryUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _update(
      EnquiryEventEditingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (event.entity.id < 0) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      emit(LoadingState());
      await dependencyResolver<UpdateEnquiryUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _importNewItems(
      EnquiryEventImport event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      await dependencyResolver<AddEnquiriesUseCase>().call(event.entities);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }


  _delete(EnquiryEventDelete event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      await dependencyResolver<DeleteEnquiryUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }
}
