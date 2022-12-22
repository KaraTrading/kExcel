import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/usecase/user/logout_user_usecase.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';
import 'package:kexcel/presenter/feature/home/profile/profile_bloc_event.dart';

@Singleton()
class ProfileBloc extends BaseBloc<ProfileBlocEvent> {

  ProfileBloc() {
    on<ProfileEventInit>(_init);
    on<ProfileEventLogout>(_logout);
  }

  _init(ProfileEventInit event, Emitter<BaseBlocState> emit) {

  }

  _logout(ProfileEventLogout event, Emitter<BaseBlocState> emit) async {
    try {
      await dependencyResolver<LogoutUserUseCase>().call(null);
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }

}
