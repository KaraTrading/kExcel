import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/entity/environment_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/domain/usecase/client/get_clients_use_case.dart';
import 'package:kexcel/domain/usecase/item/get_items_use_case.dart';
import 'package:kexcel/domain/usecase/environment/add_environment_use_case.dart';
import 'package:kexcel/domain/usecase/environment/get_latest_environment_number_use_case.dart';
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
    on<EnvironmentAddEventUpdatedProject>(_update);
  }


  late List<ClientEntity> clients = [];
  late List<SupplierEntity> suppliers = [];
  late List<ItemEntity> items = [];
  late UserEntity user;
  late CompanyEntity company;
  EnvironmentEntity? environment;
  late int latestEnvironmentNumber;

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

      latestEnvironmentNumber = await dependencyResolver<GetLatestEnvironmentNumberUseCase>().call(null);

      updateEnvironmentName();
      environment?.items = environment?.items?.map((e) => items.firstWhere((element) => element.id == e.id)).toList();

      user = (await dependencyResolver<GetUserUseCase>().call(null)) ?? UserEntity(name: 'name', companyId: 0, title: 'title', email: 'email');
      company = await dependencyResolver<GetUserCompanyUseCase>().call(null);

      emit(ResponseState<List<ItemEntity>>(data: items));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }

  _addNew(EnvironmentAddEventAddingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (environment?.name.isEmpty ?? false) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      await dependencyResolver<AddEnvironmentUseCase>().call(environment!);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  void updateEnvironmentName() {
    environment?.name = 'E-${DateTime.now().year.toString().substring(2)}${(latestEnvironmentNumber + 1).toString().padLeft(3, "0")}-${environment?.supplier?.code.substring(1) ?? '000'}';
  }


  _update(EnvironmentAddEventUpdatedProject event, Emitter<BaseBlocState> emit) {
    updateEnvironmentName();
  }
}