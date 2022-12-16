import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/domain/usecase/user/get_companies_usecase.dart';
import 'package:kexcel/domain/usecase/user/get_user_usecase.dart';
import 'package:kexcel/domain/usecase/user/set_user_usecase.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';

import 'login_bloc_event.dart';

@Singleton()
class LoginBloc extends BaseBloc {
  late List<CompanyEntity> companies = [];
  late UserEntity? user;

  LoginBloc() {
    on<LoginEventInit>(_getAll);
    on<LoginEventAddingDone>(_addNew);
  }

  _getAll(event, emit) async {
    try {
      emit(LoadingState());
      user = await dependencyResolver<GetUserUseCase>().call(null);
      companies = await dependencyResolver<GetCompaniesUseCase>().call(null);
      emit(ResponseState<List<CompanyEntity>>(data: companies));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }

  _addNew(LoginEventAddingDone event, Emitter<BaseBlocState> emit) async {
    try {
      if (event.entity.name.isEmpty || event.entity.title.isEmpty || event.entity.email.isEmpty) {
        emit.call(ErrorState(error: 'Invalid Inputs'));
        return;
      }
      emit(LoadingState());
      await dependencyResolver<SetUserUseCase>().call(event.entity);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }

}