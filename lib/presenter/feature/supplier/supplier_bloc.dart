import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/usecase/supplier/add_supplier_use_case.dart';
import 'package:kexcel/domain/usecase/supplier/get_suppliers_use_case.dart';
import 'package:kexcel/domain/usecase/supplier/update_supplier_use_case.dart';

import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';

import 'supplier_bloc_event.dart';

@Singleton()
class SupplierBloc extends BaseBloc<SupplierBlocEvent> {
  SupplierBloc() {
    on<SupplierEventInit>(_getAll);
    on<SupplierEventSearch>(_getAll);
    on<SupplierEventAddingDone>(_addNew);
    on<SupplierEventEditingDone>(_update);
  }

  late List<SupplierEntity> suppliers;

  _getAll(event, emit) async {
    try {
      emit(LoadingState());
      final getClientsUseCase = dependencyResolver<GetSuppliersUseCase>();
      suppliers = await getClientsUseCase
          .call(event is SupplierEventSearch ? event.query : null);
      emit(ResponseState<List<SupplierEntity>>(data: suppliers));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }

  _addNew(SupplierEventAddingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (event.entity.name.isEmpty) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      emit(LoadingState());
      final addUseCase = dependencyResolver<AddSupplierUseCase>();
      await addUseCase.call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _update(SupplierEventEditingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (event.entity.id < 0 || event.entity.name.isEmpty) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      emit(LoadingState());
      final updateUseCase = dependencyResolver<UpdateSupplierUseCase>();
      await updateUseCase.call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }
}
