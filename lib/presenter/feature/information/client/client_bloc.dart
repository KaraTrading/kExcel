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
    on<ClientEventInit>(_getAll);
    on<ClientEventSearch>(_getAll);
    on<ClientEventAddingDone>(_addNew);
    on<ClientEventEditingDone>(_update);
    on<ClientEventImport>(_importNewItems);
    on<ClientEventDelete>(_delete);
  }

  late List<ClientEntity> clients;

  _getAll(event, emit) async {
    try {
      emit(LoadingState());
      clients = await dependencyResolver<GetClientsUseCase>()
          .call(event is ClientEventSearch ? event.query : null);
      emit(ResponseState<List<ClientEntity>>(data: clients));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }

  _addNew(ClientEventAddingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (event.entity.name.isEmpty || event.entity.code.isEmpty) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      emit(LoadingState());
      await dependencyResolver<AddClientUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _delete(ClientEventDelete event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      await dependencyResolver<DeleteClientUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _importNewItems(ClientEventImport event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      await dependencyResolver<AddClientsUseCase>().call(event.entities);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _update(ClientEventEditingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (event.entity.id < 0 || event.entity.name.isEmpty || event.entity.code.isEmpty) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      emit(LoadingState());
      await dependencyResolver<UpdateClientUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }
}
