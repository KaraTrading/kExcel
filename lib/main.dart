import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/domain/usecase/user/get_user_usecase.dart';
import 'package:kexcel/presenter/feature/home/home_screen.dart';
import 'package:kexcel/presenter/feature/login/login_screen.dart';
import 'package:kexcel/presenter/utils/app_theme.dart';
import 'data/local/database_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await databaseConfiguration();
  await configureDependencies();
  await localization.EasyLocalization.ensureInitialized();
  final user = (await dependencyResolver<GetUserUseCase>().call(null));
  runApp(localization.EasyLocalization(
    supportedLocales: const [
      Locale('en', 'US'),
    ],
    fallbackLocale: const Locale('en', 'US'),
    useOnlyLangCode: true,
    saveLocale: true,
    path: 'assets/translations/',
    child: MyApp(isAuthorized: user != null),
  ));
}

class MyApp extends StatelessWidget {
  final bool isAuthorized;
  const MyApp({Key? key, required this.isAuthorized}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kExcel',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: isAuthorized
          ? const HomeScreen()
          : const LoginScreen(),
    );
  }
}
