import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';

abstract class BaseScreen<T extends BaseBloc> extends StatelessWidget {

  const BaseScreen({Key? key}) : super(key: key);

  abstract final AppBar? appBar;

  callEvent(BaseBlocEvent event) {
    getBloc.add(event);
  }

  T get getBloc => dependencyResolver<T>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: (context) => getBloc,
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: screenBody(context),
      floatingActionButton: floatingActionButton(context),
    );
  }

  Widget screenBody(BuildContext context);

  FloatingActionButton? floatingActionButton(BuildContext context);
}
