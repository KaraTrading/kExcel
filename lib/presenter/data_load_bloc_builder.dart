import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kexcel/presenter/base_bloc_state.dart';
import 'base_bloc.dart';

class DataLoadBlocBuilder<B extends BaseBloc, T>
    extends BlocBuilder<B, BaseBlocState> {
  DataLoadBlocBuilder({
    required Widget Function(BuildContext context, T data) builder,
    Widget? initView,
    Widget? loadingView,
    Widget Function(dynamic error)? errorViewBuilder,
    Widget? noDataView,
    Key? key,
    B? bloc,
    bool Function(BaseBlocState previous, BaseBlocState current)? buildWhen,
  }) : super(
          key: key,
          bloc: bloc,
          buildWhen: buildWhen,
          builder: (context, state) {
            if (state is InitState) {
              return initView ?? const CircularProgressIndicator();
            }
            if (state is LoadingState) {
              return loadingView ?? const CircularProgressIndicator();
            }
            if (state is ErrorState) {
              return errorViewBuilder?.call(state.error) ??
                  Text(state.error?.toString() ?? '');
            }
            if (state is ResponseState) {
              return state.noData
                  ? (noDataView ?? const Text('No Data'))
                  : builder.call(context, state.data);
            }
            return const SizedBox();
          },
        );
}
