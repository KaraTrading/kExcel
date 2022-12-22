import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/usecase/client/get_clients_use_case.dart';
import 'package:kexcel/domain/usecase/item/get_items_use_case.dart';
import 'package:kexcel/domain/usecase/project/add_project_use_case.dart';
import 'package:kexcel/domain/usecase/project/add_projects_use_case.dart';
import 'package:kexcel/domain/usecase/project/delete_project_use_case.dart';
import 'package:kexcel/domain/usecase/project/get_projects_use_case.dart';
import 'package:kexcel/domain/usecase/project/update_project_use_case.dart';
import 'package:kexcel/domain/usecase/supplier/get_suppliers_use_case.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';
import 'project_bloc_event.dart';

@Singleton()
class ProjectBloc extends BaseBloc<ProjectBlocEvent> {
  ProjectBloc() {
    on<ProjectEventInit>(_getAll);
    on<ProjectEventSearch>(_getAll);
    on<ProjectEventAddingDone>(_addNew);
    on<ProjectEventEditingDone>(_update);
    on<ProjectEventImport>(_importNewItems);
    on<ProjectEventDelete>(_delete);
  }

  late List<ClientEntity> clients = [];
  late List<SupplierEntity> suppliers = [];
  late List<ItemEntity> items = [];
  late List<ProjectEntity> projectsItems = [];

  _getAll(event, emit) async {
    try {
      emit(LoadingState());

      if (clients.isEmpty) {
        clients = await dependencyResolver<GetClientsUseCase>().call(null);
      }

      if (suppliers.isEmpty) {
        suppliers = await dependencyResolver<GetSuppliersUseCase>().call(null);
      }

      if (items.isEmpty) {
        items = await dependencyResolver<GetItemsUseCase>().call(null);
      }

      projectsItems = await dependencyResolver<GetProjectsUseCase>()
          .call(event is ProjectEventSearch ? event.query : null);
      emit(ResponseState<List<ProjectEntity>>(data: projectsItems));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }

  _addNew(ProjectEventAddingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (event.entity.name.isEmpty) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      emit(LoadingState());
      await dependencyResolver<AddProjectUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _update(
      ProjectEventEditingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (event.entity.id < 0 || event.entity.name.isEmpty) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      emit(LoadingState());
      await dependencyResolver<UpdateProjectUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _importNewItems(
      ProjectEventImport event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      await dependencyResolver<AddProjectsUseCase>().call(event.entities);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }


  _delete(ProjectEventDelete event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      await dependencyResolver<DeleteProjectUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }
}
