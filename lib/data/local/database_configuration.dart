import 'package:hive_flutter/hive_flutter.dart';

import 'model/client_data.dart';
import 'model/logistic_data.dart';
import 'model/project_item_data.dart';
import 'model/supplier_data.dart';
import 'model/item_data.dart';

const String clientTableName = 'clients';
const String supplierTableName = 'suppliers';
const String logisticTableName = 'logistics';
const String itemTableName = 'items';
const String projectsItemTableName = 'projectsItems';

late final Box<ClientData> clientBox;
late final Box<SupplierData> supplierBox;
late final Box<LogisticData> logisticBox;
late final Box<ItemData> itemBox;
late final Box<ProjectItemData> projectItemBox;

Future<void> databaseConfiguration() async {
  await Hive.initFlutter();
  Hive.registerAdapter<ClientData>(ClientDataAdapter());
  clientBox = await Hive.openBox<ClientData>(clientTableName);
  Hive.registerAdapter<SupplierData>(SupplierDataAdapter());
  supplierBox = await Hive.openBox<SupplierData>(supplierTableName);
  Hive.registerAdapter<LogisticData>(LogisticDataAdapter());
  logisticBox = await Hive.openBox<LogisticData>(logisticTableName);
  Hive.registerAdapter<ItemData>(ItemDataAdapter());
  itemBox = await Hive.openBox<ItemData>(itemTableName);
  Hive.registerAdapter<ProjectItemData>(ProjectItemDataAdapter());
  projectItemBox = await Hive.openBox<ProjectItemData>(projectsItemTableName);
}