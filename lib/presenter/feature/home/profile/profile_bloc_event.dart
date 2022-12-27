import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class ProfileBlocEvent extends BaseBlocEvent {}

class ProfileEventInit extends ProfileBlocEvent {}

class ProfileEventEdited extends ProfileBlocEvent {
  UserEntity user;
  ProfileEventEdited(this.user);
}

class ProfileEventLogout extends ProfileBlocEvent {}