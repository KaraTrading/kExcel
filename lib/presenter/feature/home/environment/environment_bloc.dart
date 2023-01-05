import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/environment_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/usecase/environment/add_environment_use_case.dart';
import 'package:kexcel/domain/usecase/environment/add_environments_use_case.dart';
import 'package:kexcel/domain/usecase/environment/delete_environment_use_case.dart';
import 'package:kexcel/domain/usecase/environment/get_environments_use_case.dart';
import 'package:kexcel/domain/usecase/environment/update_environment_use_case.dart';
import 'package:kexcel/domain/usecase/supplier/get_suppliers_use_case.dart';
import 'package:kexcel/domain/usecase/user/get_user_company_usecase.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';
import 'environment_bloc_event.dart';

@Singleton()
class EnvironmentBloc extends BaseBloc<EnvironmentBlocEvent> {
  EnvironmentBloc() {
    on<EnvironmentEventInit>(_getAll);
    on<EnvironmentEventSearch>(_getAll);
    on<EnvironmentEventAddingDone>(_addNew);
    on<EnvironmentEventEditingDone>(_update);
    on<EnvironmentEventImport>(_importNewItems);
    on<EnvironmentEventDelete>(_delete);
  }

  late CompanyEntity company;
  late List<SupplierEntity> suppliers = [];
  late List<EnvironmentEntity> environments = [];

  _getAll(event, emit) async {
    try {
      emit(LoadingState());

      company = await dependencyResolver<GetUserCompanyUseCase>().call(null);

      if (suppliers.isEmpty) {
        suppliers = await dependencyResolver<GetSuppliersUseCase>().call(null);
      }

      environments = await dependencyResolver<GetEnvironmentsUseCase>()
          .call(event is EnvironmentEventSearch ? event.query : null);
      emit(ResponseState<List<EnvironmentEntity>>(data: environments));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }

  _addNew(EnvironmentEventAddingDone event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      await dependencyResolver<AddEnvironmentUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _update(
      EnvironmentEventEditingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (event.entity.id < 0) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      emit(LoadingState());
      await dependencyResolver<UpdateEnvironmentUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _importNewItems(
      EnvironmentEventImport event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      await dependencyResolver<AddEnvironmentsUseCase>().call(event.entities);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }


  _delete(EnvironmentEventDelete event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      await dependencyResolver<DeleteEnvironmentUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }
}
