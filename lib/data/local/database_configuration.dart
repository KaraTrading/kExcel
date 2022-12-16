import 'package:hive_flutter/hive_flutter.dart';

import 'model/client_data.dart';
import 'model/company_data.dart';
import 'model/logistic_data.dart';
import 'model/project_item_data.dart';
import 'model/supplier_data.dart';
import 'model/item_data.dart';

const int clientTableTypeId = 1;
const String clientTableName = 'clients';
const int supplierTableTypeId = 3;
const String supplierTableName = 'suppliers';
const int logisticTableTypeId = 2;
const String logisticTableName = 'logistics';
const int itemTableTypeId = 4;
const String itemTableName = 'items';
const int projectsItemTableTypeId = 0;
const String projectsItemTableName = 'projectsItems';
const int companyTableTypeId = 5;
const String companyTableName = 'companies';

late final Box<ClientData> clientBox;
late final Box<SupplierData> supplierBox;
late final Box<LogisticData> logisticBox;
late final Box<ItemData> itemBox;
late final Box<ProjectItemData> projectItemBox;
late final Box<CompanyData> companyBox;

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
  Hive.registerAdapter<CompanyData>(CompanyDataAdapter());
  companyBox = await Hive.openBox<CompanyData>(companyTableName);
}