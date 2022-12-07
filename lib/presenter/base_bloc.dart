import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';

abstract class BaseBloc<E extends BaseBlocEvent> extends Bloc<E, BaseBlocState> {
  BaseBloc() : super(InitState());
}