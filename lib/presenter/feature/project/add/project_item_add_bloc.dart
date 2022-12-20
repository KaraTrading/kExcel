import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/domain/usecase/client/get_clients_use_case.dart';
import 'package:kexcel/domain/usecase/item/get_items_use_case.dart';
import 'package:kexcel/domain/usecase/project/add_project_use_case.dart';
import 'package:kexcel/domain/usecase/supplier/get_suppliers_use_case.dart';
import 'package:kexcel/domain/usecase/user/get_user_company_usecase.dart';
import 'package:kexcel/domain/usecase/user/get_user_usecase.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';
import 'package:kexcel/presenter/feature/project/add/project_item_add_bloc_event.dart';

@Singleton()
class ProjectItemAddBloc extends BaseBloc<ProjectItemAddBlocEvent> {
  ProjectItemAddBloc() {
    on<ProjectItemAddEventInit>(_getAll);
    on<ProjectItemEventAddingDone>(_addNew);
  }


  late List<ClientEntity> clients = [];
  late List<SupplierEntity> suppliers = [];
  late List<ItemEntity> items = [];
  late UserEntity user;
  late CompanyEntity company;
  late ProjectEntity project;


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

      project.items = project.items?.map((e) => items.firstWhere((element) => element.id == e.id)).toList();

      user = (await dependencyResolver<GetUserUseCase>().call(null)) ?? UserEntity(name: 'name', companyId: 0, title: 'title', email: 'email');
      company = await dependencyResolver<GetUserCompanyUseCase>().call(null);

      emit(ResponseState<List<ItemEntity>>(data: items));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }

  _addNew(ProjectItemEventAddingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (project.name.isEmpty) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      emit(LoadingState());
      await dependencyResolver<AddProjectUseCase>().call(project);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

}