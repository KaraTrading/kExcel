import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/usecase/supplier/add_supplier_use_case.dart';
import 'package:kexcel/domain/usecase/supplier/add_suppliers_use_case.dart';
import 'package:kexcel/domain/usecase/supplier/delete_supplier_use_case.dart';
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
    on<SupplierEventImport>(_importNewItems);
    on<SupplierEventDelete>(_delete);
  }

  late List<SupplierEntity> suppliers;

  _getAll(event, emit) async {
    try {
      emit(LoadingState());
      suppliers = await dependencyResolver<GetSuppliersUseCase>()
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
      await dependencyResolver<AddSupplierUseCase>().call(event.entity);
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
      await dependencyResolver<UpdateSupplierUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _importNewItems(
      SupplierEventImport event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      await dependencyResolver<AddSuppliersUseCase>().call(event.entities);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }


  _delete(SupplierEventDelete event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      await dependencyResolver<DeleteSupplierUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }
}
