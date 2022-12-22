import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class ProfileBlocEvent extends BaseBlocEvent {}

class ProfileEventInit extends ProfileBlocEvent {}

class ProfileEventLogout extends ProfileBlocEvent {}