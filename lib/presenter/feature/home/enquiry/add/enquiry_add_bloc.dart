import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/enquiry_entity.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/domain/usecase/client/get_clients_use_case.dart';
import 'package:kexcel/domain/usecase/enquiry/update_enquiry_use_case.dart';
import 'package:kexcel/domain/usecase/enquiry/add_enquiry_use_case.dart';
import 'package:kexcel/domain/usecase/supplier/get_suppliers_use_case.dart';
import 'package:kexcel/domain/usecase/user/get_user_company_usecase.dart';
import 'package:kexcel/domain/usecase/user/get_user_usecase.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';
import 'enquiry_add_bloc_event.dart';

@LazySingleton()
class EnquiryAddBloc extends BaseBloc<EnquiryAddBlocEvent> {
  EnquiryAddBloc() {
    on<EnquiryAddEventInit>(_getAll);
    on<EnquiryAddEventAddingDone>(_addNew);
  }

  Set<SupplierEntity> selectedSuppliers = {};
  late List<ClientEntity> clients = [];
  late List<SupplierEntity> suppliers = [];
  late UserEntity user;
  late CompanyEntity company;
  late EnquiryEntity enquiry;
  late bool isModify;

  _getAll(EnquiryAddEventInit event, emit) async {
    try {
      enquiry = event.entity;

      isModify = event.entity.id >= 0;

      emit(LoadingState());
      if (clients.isEmpty) {
        clients = await dependencyResolver<GetClientsUseCase>().call(null);
      }

      if (suppliers.isEmpty) {
        suppliers = await dependencyResolver<GetSuppliersUseCase>().call(null);
      }

      if (enquiry.supplier != null) {
        selectedSuppliers.add(enquiry.supplier!);
      }

      user = (await dependencyResolver<GetUserUseCase>().call(null))!;
      company = await dependencyResolver<GetUserCompanyUseCase>().call(null);

      emit(ResponseState<List<ProjectItemEntity>>(data: enquiry.project.items));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }

  _addNew(
      EnquiryAddEventAddingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (enquiry.project.id < 0) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      if (!selectedSuppliers.contains(enquiry.supplier)) {
        enquiry.id = -1;
      }
      if (enquiry.id < 0) {
        enquiry.id = await dependencyResolver<AddEnquiryUseCase>().call(enquiry);
      } else {
        await dependencyResolver<UpdateEnquiryUseCase>().call(enquiry);
      }
      if (enquiry.supplier != null) {
        selectedSuppliers.add(enquiry.supplier!);
      }
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }
}
