import 'package:flutter/material.dart';
import 'package:kexcel/core/di/dependency_injector.dart';
import 'package:kexcel/presenter/feature/home/home_screen.dart';
import 'data/local/database_configuration.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}