import 'package:flutter/material.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'login_bloc.dart';

class LoginScreen extends BaseScreen<LoginBloc> {
  const LoginScreen({super.key});

  @override
  AppBar? get appBar => null;

  @override
  FloatingActionButton? floatingActionButton(BuildContext context) => null;

  @override
  Widget screenBody(BuildContext context) {
    return Container();
  }

}