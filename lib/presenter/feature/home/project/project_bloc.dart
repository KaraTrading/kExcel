import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/core/exception/network_exception.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/domain/usecase/project/delete_project_use_case.dart';
import 'package:kexcel/domain/usecase/project/get_projects_use_case.dart';
import 'package:kexcel/domain/usecase/user/get_user_company_usecase.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';
import 'project_bloc_event.dart';

@Singleton()
class ProjectBloc extends BaseBloc<ProjectBlocEvent> {
  ProjectBloc() {
    on<ProjectEventInit>(_getAll);
    on<ProjectEventSearch>(_getAll);
    on<ProjectEventDelete>(_delete);
  }

  late List<ProjectEntity> projects = [];
  late CompanyEntity company;

  _getAll(event, emit) async {
    try {
      emit(LoadingState());

      company = await dependencyResolver<GetUserCompanyUseCase>().call(null);
      projects = await dependencyResolver<GetProjectsUseCase>()
          .call(event is ProjectEventSearch ? event.query : null);
      emit(ResponseState<List<ProjectEntity>>(data: projects));
    } on BaseNetworkException catch (e) {
      emit(ErrorState(error: e));
    } on BaseException catch (e) {
      emit(ErrorState(error: e));
    }
  }

  _delete(ProjectEventDelete event, Emitter<BaseBlocState> emit) async {
    try {
      emit(LoadingState());
      await dependencyResolver<DeleteProjectUseCase>().call(event.entity);
      return _getAll(event, emit);
    } on BaseNetworkException catch (e) {
      emit.call(ErrorState(error: e));
    } on BaseException catch (e) {
      emit.call(ErrorState(error: e));
    }
  }
}
