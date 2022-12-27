import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/domain/usecase/user/get_user_company_usecase.dart';
import 'package:kexcel/domain/usecase/user/get_user_usecase.dart';
import 'package:kexcel/domain/usecase/user/logout_user_usecase.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';
import 'package:kexcel/presenter/feature/home/profile/profile_bloc_event.dart';
import 'package:package_info_plus/package_info_plus.dart';

@Singleton()
class ProfileBloc extends BaseBloc<ProfileBlocEvent> {

  late String version;
  late String appName;
  late UserEntity? user;
  late CompanyEntity? company;

  ProfileBloc() {
    on<ProfileEventInit>(_init);
    on<ProfileEventLogout>(_logout);
  }

  _init(ProfileEventInit event, Emitter<BaseBlocState> emit) async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      version = packageInfo.version;
      appName = packageInfo.appName;
      user = await dependencyResolver<GetUserUseCase>().call(null);
      company = await dependencyResolver<GetUserCompanyUseCase>().call(null);
      emit(ResponseState(data: user));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
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
