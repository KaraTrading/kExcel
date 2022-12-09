import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'dependency_injector.config.dart';

final dependencyResolver = GetIt.instance;

// flutter packages pub run build_runner build --delete-conflicting-outputs

@InjectableInit(
  initializerName: r'$initGetIt', // default
  asExtension: false, // default
)
Future<void> configureDependencies() async {
  $initGetIt(dependencyResolver);
}
