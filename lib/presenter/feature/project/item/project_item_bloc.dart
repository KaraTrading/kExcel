import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/usecase/client/get_clients_use_case.dart';
import 'package:kexcel/domain/usecase/project/item/add_project_Item_use_case.dart';
import 'package:kexcel/domain/usecase/project/item/get_projects_items_use_case.dart';
import 'package:kexcel/domain/usecase/project/item/update_project_Item_use_case.dart';
import 'package:kexcel/domain/usecase/supplier/get_suppliers_use_case.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';
import 'project_item_bloc_event.dart';


@Singleton()
class ProjectItemBloc extends BaseBloc<ProjectItemBlocEvent> {

  ProjectItemBloc() {
    on<ProjectItemEventInit>(_getAll);
    on<ProjectItemEventSearch>(_getAll);
    on<ProjectItemEventAddingDone>(_addNew);
    on<ProjectItemEventEditingDone>(_update);
  }

  late List<ClientEntity> clients = [];
  late List<SupplierEntity> suppliers = [];
  late List<ProjectItemEntity> projectsItems = [];

  _getAll(event, emit) async {
    try {
      emit(LoadingState());

      if (clients.isEmpty) {
        final getAllClientsUseCase = dependencyResolver<GetClientsUseCase>();
        clients = await getAllClientsUseCase.call(null);
      }

      if (suppliers.isEmpty) {
        final getAllSuppliersUseCase = dependencyResolver<GetSuppliersUseCase>();
        suppliers = await getAllSuppliersUseCase.call(null);
      }

      final getAllUseCase = dependencyResolver<GetProjectItemsUseCase>();
      projectsItems = await getAllUseCase
          .call(event is ProjectItemEventSearch ? event.query : null);
      emit(ResponseState<List<ProjectItemEntity>>(data: projectsItems));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }

  _addNew(ProjectItemEventAddingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (event.entity.name.isEmpty) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      emit(LoadingState());
      final addUseCase = dependencyResolver<AddProjectItemUseCase>();
      await addUseCase.call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _update(ProjectItemEventEditingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (event.entity.id < 0 || event.entity.name.isEmpty) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      emit(LoadingState());
      final updateUseCase = dependencyResolver<UpdateProjectItemUseCase>();
      await updateUseCase.call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }
}
