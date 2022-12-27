import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class LoginBlocEvent extends BaseBlocEvent {}

class LoginEventInit extends LoginBlocEvent {
  final UserEntity? user;
  LoginEventInit(this.user);
}
class LoginEventAddingDone extends LoginBlocEvent {
  final UserEntity entity;
  LoginEventAddingDone(this.entity);
}