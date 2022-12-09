import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/presenter/feature/home/home_screen.dart';
import 'package:kexcel/presenter/utils/app_colors.dart';
import 'data/local/database_configuration.dart';
import 'presenter/utils/text_styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await databaseConfiguration();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kExcel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
          appBarTheme: AppBarTheme(
            titleTextStyle: headerTextStyle.large.onPrimary,
            backgroundColor: primaryColor,
            foregroundColor: onPrimaryColor,
            elevation: 1,
            centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: primaryDarkerColor,
            ),
          ),
          textTheme: TextTheme(
            displayLarge: headerTextStyle.medium,
            displayMedium: titleTextStyle.medium,
            displaySmall: captionTextStyle.medium,
            headlineLarge: headerTextStyle.large,
            headlineMedium: headerTextStyle.medium,
            headlineSmall: headerTextStyle.small,
            titleLarge: titleTextStyle.large,
            titleMedium: titleTextStyle.medium,
            titleSmall: titleTextStyle.small,
            bodyLarge: primaryTextStyle.large,
            bodyMedium: primaryTextStyle.medium,
            bodySmall: primaryTextStyle.small,
            labelLarge: captionTextStyle.large,
            labelMedium: captionTextStyle.medium,
            labelSmall: captionTextStyle.small,
          )),
      home: const HomeScreen(),
    );
  }
}
