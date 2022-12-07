import 'package:hive_flutter/hive_flutter.dart';
import 'package:kexcel/data/local/model/client_data.dart';
import 'package:kexcel/data/local/model/logistic_data.dart';
import 'package:kexcel/data/local/model/project_item_data.dart';
import 'package:kexcel/data/local/model/supplier_data.dart';

const String clientTableName = 'clients';
const String supplierTableName = 'suppliers';
const String logisticTableName = 'logistics';
const String projectsItemTableName = 'projectsItems';

late final Box<ClientData> clientBox;
late final Box<SupplierData> supplierBox;
late final Box<LogisticData> logisticBox;
late final Box<ProjectItemData> projectItemBox;

Future<void> databaseConfiguration() async {
  await Hive.initFlutter();
  clientBox = await Hive.openBox<ClientData>(clientTableName);
  Hive.registerAdapter(ClientDataAdapter());
  supplierBox = await Hive.openBox<SupplierData>(supplierTableName);
  Hive.registerAdapter(SupplierDataAdapter());
  logisticBox = await Hive.openBox<LogisticData>(logisticTableName);
  Hive.registerAdapter(LogisticDataAdapter());
  projectItemBox = await Hive.openBox<ProjectItemData>(projectsItemTableName);
  Hive.registerAdapter(ProjectItemDataAdapter());
}