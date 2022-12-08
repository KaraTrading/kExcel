import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/usecase/client/add_client_use_case.dart';
import 'package:kexcel/domain/usecase/client/add_clients_use_case.dart';
import 'package:kexcel/domain/usecase/client/delete_client_use_case.dart';
import 'package:kexcel/domain/usecase/client/get_clients_use_case.dart';
import 'package:kexcel/domain/usecase/client/update_client_use_case.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';
import 'client_bloc_event.dart';

@Singleton()
class ClientBloc extends BaseBloc<ClientBlocEvent> {
  ClientBloc() {
    on<ClientEventInit>(_getClients);
    on<ClientEventSearch>(_getClients);
    on<ClientEventAddingDone>(_addNewClient);
    on<ClientEventEditingDone>(_updateClient);
    on<ClientEventImport>(_addNewClients);
    on<ClientEventDelete>(_deleteClient);
  }

  late List<ClientEntity> clients;

  _getClients(event, emit) async {
    try {
      emit(LoadingState());
      final getClientsUseCase = dependencyResolver<GetClientsUseCase>();
      clients = await getClientsUseCase
          .call(event is ClientEventSearch ? event.query : null);
      emit(ResponseState<List<ClientEntity>>(data: clients));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }

  _addNewClient(ClientEventAddingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (event.client.name.isEmpty || event.client.code.isEmpty) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      emit(LoadingState());
      final addClientsUseCase = dependencyResolver<AddClientUseCase>();
      await addClientsUseCase.call(event.client);
      return _getClients(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _deleteClient(ClientEventDelete event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      final deleteUseCase = dependencyResolver<DeleteClientUseCase>();
      await deleteUseCase.call(event.client);
      return _getClients(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _addNewClients(ClientEventImport event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      final addClientsUseCase = dependencyResolver<AddClientsUseCase>();
      await addClientsUseCase.call(event.clients);
      return _getClients(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _updateClient(ClientEventEditingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (event.client.id < 0 || event.client.name.isEmpty || event.client.code.isEmpty) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      emit(LoadingState());
      final addClientsUseCase = dependencyResolver<UpdateClientUseCase>();
      await addClientsUseCase.call(event.client);
      return _getClients(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }
}
