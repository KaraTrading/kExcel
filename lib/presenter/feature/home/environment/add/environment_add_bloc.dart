import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/environment_entity.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/domain/usecase/client/get_clients_use_case.dart';
import 'package:kexcel/domain/usecase/environment/update_environment_use_case.dart';
import 'package:kexcel/domain/usecase/environment/add_environment_use_case.dart';
import 'package:kexcel/domain/usecase/supplier/get_suppliers_use_case.dart';
import 'package:kexcel/domain/usecase/user/get_user_company_usecase.dart';
import 'package:kexcel/domain/usecase/user/get_user_usecase.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';
import 'environment_add_bloc_event.dart';

@LazySingleton()
class EnvironmentAddBloc extends BaseBloc<EnvironmentAddBlocEvent> {
  EnvironmentAddBloc() {
    on<EnvironmentAddEventInit>(_getAll);
    on<EnvironmentAddEventAddingDone>(_addNew);
  }

  Set<SupplierEntity> selectedSuppliers = {};
  late List<ClientEntity> clients = [];
  late List<SupplierEntity> suppliers = [];
  late UserEntity user;
  late CompanyEntity company;
  late EnvironmentEntity environment;
  late bool isModify;

  _getAll(EnvironmentAddEventInit event, emit) async {
    try {
      environment = event.entity;

      isModify = event.entity.id >= 0;

      emit(LoadingState());
      if (clients.isEmpty) {
        clients = await dependencyResolver<GetClientsUseCase>().call(null);
      }

      if (suppliers.isEmpty) {
        suppliers = await dependencyResolver<GetSuppliersUseCase>().call(null);
      }

      if (environment.supplier != null) {
        selectedSuppliers.add(environment.supplier!);
      }

      user = (await dependencyResolver<GetUserUseCase>().call(null))!;
      company = await dependencyResolver<GetUserCompanyUseCase>().call(null);

      emit(ResponseState<List<ProjectItemEntity>>(data: environment.project.items));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }

  _addNew(
      EnvironmentAddEventAddingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (environment.project.id < 0) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      if (!selectedSuppliers.contains(environment.supplier)) {
        environment.id = -1;
      }
      if (environment.id < 0) {
        environment.id = await dependencyResolver<AddEnvironmentUseCase>().call(environment);
      } else {
        await dependencyResolver<UpdateEnvironmentUseCase>().call(environment);
      }
      if (environment.supplier != null) {
        selectedSuppliers.add(environment.supplier!);
      }
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }
}
