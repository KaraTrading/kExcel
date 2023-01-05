import 'package:hive_flutter/hive_flutter.dart';

import 'model/attachment_data.dart';
import 'model/client_data.dart';
import 'model/company_data.dart';
import 'model/environment_data.dart';
import 'model/project_data.dart';
import 'model/supplier_data.dart';
import 'model/item_data.dart';

const int clientTableTypeId = 1;
const String clientTableName = 'clients';
const int supplierTableTypeId = 3;
const String supplierTableName = 'suppliers';
const int itemTableTypeId = 4;
const String itemTableName = 'items';
const int companyTableTypeId = 5;
const String companyTableName = 'companies';
const int attachmentTableTypeId = 7;
const String attachmentTableName = 'attachments';
const int projectTableTypeId = 10;
const String projectTableName = 'projectTable';
const int environmentTableTypeId = 12;
const String environmentTableName = 'environmentTable';

late final Box<ClientData> clientBox;
late final Box<SupplierData> supplierBox;
late final Box<ItemData> itemBox;
late final Box<EnvironmentData> environmentBox;
late final Box<ProjectData> projectBox;
late final Box<CompanyData> companyBox;
late final Box<AttachmentData> attachmentBox;

Future<void> databaseConfiguration() async {
  await Hive.initFlutter();
  Hive.registerAdapter<CompanyData>(CompanyDataAdapter());
  companyBox = await Hive.openBox<CompanyData>(companyTableName);
  Hive.registerAdapter<ClientData>(ClientDataAdapter());
  clientBox = await Hive.openBox<ClientData>(clientTableName);
  Hive.registerAdapter<SupplierData>(SupplierDataAdapter());
  supplierBox = await Hive.openBox<SupplierData>(supplierTableName);
  Hive.registerAdapter<AttachmentData>(AttachmentDataAdapter());
  attachmentBox = await Hive.openBox<AttachmentData>(attachmentTableName);
  Hive.registerAdapter<ItemData>(ItemDataAdapter());
  itemBox = await Hive.openBox<ItemData>(itemTableName);
  Hive.registerAdapter<ProjectData>(ProjectDataAdapter());
  projectBox = await Hive.openBox<ProjectData>(projectTableName);
  Hive.registerAdapter<EnvironmentData>(EnvironmentDataAdapter());
  environmentBox = await Hive.openBox<EnvironmentData>(environmentTableName);
}