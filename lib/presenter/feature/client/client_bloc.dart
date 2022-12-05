import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/usecase/add_client_use_case.dart';
import 'package:kexcel/domain/usecase/get_clients_use_case.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';
import 'client_bloc_event.dart';

@Injectable()
class ClientBloc extends BaseBloc {
  ClientBloc() {
    on<InitializedEvent>(_getClients);
    on<ClientEventSearch>(_getClients);
    on<ClientEventAddingNameChanged>(_updateNewName);
    on<ClientEventAddingDone>(_addNewClient);
  }

  _getClients(BaseBlocEvent event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      final getClientsUseCase = dependencyResolver<GetClientsUseCase>();
      final data = await getClientsUseCase
          .call(event is ClientEventSearch ? event.query : null);
      emit(ResponseState(data: data));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }

  _addNewClient(
      ClientEventAddingDone event, Emitter<BaseBlocState> emit) async {
    try {
      final String? name = (state as InitState).value;
      if (name?.isEmpty ?? true) {
        emit(ErrorState(error: 'Enter name'));
        return;
      }
      emit(LoadingState());
      final addClientsUseCase = dependencyResolver<AddClientUseCase>();
      final data = await addClientsUseCase
          .call(ClientEntity(id: 0, name: name!, code: ''));
      emit(ResponseState(data: data));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }

  _updateNewName(
      ClientEventAddingNameChanged event, Emitter<BaseBlocState> emit) {
    return emit(InitState(value: event.name));
  }
}
