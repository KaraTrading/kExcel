import 'package:hive_flutter/hive_flutter.dart';

const String clientTableName = 'clients';
const String supplierTableName = 'suppliers';
const String logisticTableName = 'logistics';
const String projectsItemTableName = 'projectsItems';

Future<void> databaseConfiguration() async {
  await Hive.initFlutter();
}