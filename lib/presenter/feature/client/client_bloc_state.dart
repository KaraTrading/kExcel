import 'package:kexcel/presenter/base_bloc_state.dart';

abstract class ClientBlocState extends BaseBlocState {}

class ClientBlocStateInit extends ClientBlocState {
  String name;
  ClientBlocStateInit(this.name);
}