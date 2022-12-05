import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/data/datasource/project/project_local_data_source.dart';
import 'package:kexcel/data/datasource/project/project_local_data_source_impl.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/presenter/feature/client/client_bloc.dart';
import 'package:kexcel/presenter/feature/client/client_screen.dart';
import 'package:kexcel/presenter/feature/home/home_screen.dart';

import 'dependency_injector.config.dart';

final dependencyResolver = GetIt.instance;

// flutter packages pub run build_runner build
// flutter packages pub run build_runner build --delete-conflicting-outputs

@InjectableInit(
  initializerName: r'$initGetIt', // default
  asExtension: false, // default
)
Future<void> configureDependencies() async {
  $initGetIt(dependencyResolver);

  // dependencyResolver.registerFactory<HomeScreen>(() => const HomeScreen());
  //
  // dependencyResolver.registerFactory<ClientScreen>(() => const ClientScreen());
  // dependencyResolver.registerFactory<ClientBloc>(() => ClientBloc());

  // dependencyResolver.registerSingleton<ClientBloc>(() => ClientBloc());

  // dependencyResolver.registerSingletonWithDependencies(() => ProjectLocalDataSourceImpl(storage: storage, clientStorage: clientStorage, supplierStorage: supplierStorage, logisticStorage: logisticStorage)<ProjectItemEntity>());
}
