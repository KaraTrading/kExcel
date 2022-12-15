import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/usecase/item/add_item_use_case.dart';
import 'package:kexcel/domain/usecase/item/add_items_use_case.dart';
import 'package:kexcel/domain/usecase/item/delete_item_use_case.dart';
import 'package:kexcel/domain/usecase/item/get_items_use_case.dart';
import 'package:kexcel/domain/usecase/item/update_item_use_case.dart';
import 'package:kexcel/domain/usecase/supplier/add_supplier_use_case.dart';
import 'package:kexcel/domain/usecase/supplier/get_manufacturers_use_case.dart';
import 'package:kexcel/domain/usecase/supplier/get_suppliers_use_case.dart';
import 'package:kexcel/domain/usecase/supplier/update_supplier_use_case.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';
import 'package:kexcel/presenter/feature/information/item/item_bloc_event.dart';

@Singleton()
class ItemBloc extends BaseBloc<ItemBlocEvent>{
  late List<ItemEntity> items = [];
  late List<SupplierEntity> manufacturers = [];

  ItemBloc() {
    on<ItemEventInit>(_getAll);
    on<ItemEventSearch>(_getAll);
    on<ItemEventAddingDone>(_addNew);
    on<ItemEventEditingDone>(_update);
    on<ItemEventImport>(_importNewItems);
    on<ItemEventAddManufacturer>(_importManufacturer);
    on<ItemEventDelete>(_delete);
  }

  _getAll(event, emit) async {
    try {
      emit(LoadingState());
        items = await dependencyResolver<GetItemsUseCase>().call(event is ItemEventSearch ? event.query : null);
      if (manufacturers.isEmpty) {
        manufacturers = await dependencyResolver<GetManufacturersUseCase>().call(null);
      }
      emit(ResponseState<List<ItemEntity>>(data: items));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }


  _addNew(ItemEventAddingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (event.entity.name.isEmpty || (event.entity.hsCode?.isEmpty ?? true)) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      emit(LoadingState());
      await dependencyResolver<AddItemUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _importManufacturer(ItemEventAddManufacturer event, Emitter<BaseBlocState> emit) async {
    try {
      final suppliers = await dependencyResolver<GetSuppliersUseCase>().call(null);
      for (var element in suppliers) {
        if (element.name.contains(event.manufacturerName) || (element.symbol?.contains(event.manufacturerName) ?? false)) {
          final supplier = element;
          supplier.isManufacturer = true;
          await dependencyResolver<UpdateSupplierUseCase>().call(supplier);
          return;
        }
      }
      await dependencyResolver<AddSupplierUseCase>().call(SupplierEntity(id: 0, code: 'M000', name: event.manufacturerName));
      return;
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _delete(ItemEventDelete event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      await dependencyResolver<DeleteItemUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _importNewItems(ItemEventImport event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      await dependencyResolver<AddItemsUseCase>().call(event.entities);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

  _update(ItemEventEditingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (event.entity.id < 0 || event.entity.name.isEmpty || (event.entity.hsCode?.isEmpty ?? true)) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      emit(LoadingState());
      await dependencyResolver<UpdateItemUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }
}