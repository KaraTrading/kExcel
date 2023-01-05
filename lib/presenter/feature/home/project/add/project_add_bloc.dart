import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/domain/usecase/client/get_clients_use_case.dart';
import 'package:kexcel/domain/usecase/item/get_items_use_case.dart';
import 'package:kexcel/domain/usecase/project/add_project_use_case.dart';
import 'package:kexcel/domain/usecase/project/update_project_use_case.dart';
import 'package:kexcel/domain/usecase/supplier/get_suppliers_use_case.dart';
import 'package:kexcel/domain/usecase/user/get_user_company_usecase.dart';
import 'package:kexcel/domain/usecase/user/get_user_usecase.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';
import 'package:kexcel/presenter/common/environment_name_formatter.dart';
import 'project_add_bloc_event.dart';

@LazySingleton()
class ProjectAddBloc extends BaseBloc<ProjectAddBlocEvent> {
  ProjectAddBloc() {
    on<ProjectAddEventInit>(_getAll);
    on<ProjectAddEventAddingDone>(_addNew);
  }

  ProjectEntity? project;

  ClientEntity? selectedClient;
  Set<ProjectItemEntity> selectedProjectItems = {};
  Set<SupplierEntity> selectedSuppliers = {};

  late List<ClientEntity> clients = [];
  late List<SupplierEntity> suppliers = [];
  late List<ItemEntity> items = [];

  late UserEntity user;
  late CompanyEntity company;
  late bool isModify;
  late int latestProjectNumber;

  _getAll(ProjectAddEventInit event, emit) async {
    try {
      if (event.entity != null) {
        isModify = true;
        project = event.entity!;
      } else {
        isModify = false;
      }
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

      if (project != null) {
        for (var projectItems in project!.items) {
          projectItems.item =
              items.firstWhere((item) => item.id == projectItems.item.id);
        }

        for (var winners in project!.winners) {
          winners = suppliers.firstWhere((item) => item.id == winners.id);
        }
      }

      user = (await dependencyResolver<GetUserUseCase>().call(null))!;
      company = await dependencyResolver<GetUserCompanyUseCase>().call(null);

      emit(ResponseState<List<ItemEntity>>(data: items));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }

  _addNew(ProjectAddEventAddingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if ((project?.id ?? -1) < 0) {
        project = ProjectEntity(
          client: selectedClient!,
          date: DateTime.now(),
          annualId: annualId,
          winners: selectedSuppliers.toList(),
          items: selectedProjectItems.toList(),
        );
        project!.id =
            await dependencyResolver<AddProjectUseCase>().call(project!);
      } else {
        await dependencyResolver<UpdateProjectUseCase>().call(project!);
      }
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }
}
