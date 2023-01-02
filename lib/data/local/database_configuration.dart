import 'package:hive_flutter/hive_flutter.dart';

import 'model/attachment_data.dart';
import 'model/client_data.dart';
import 'model/company_data.dart';
import 'model/environment_data.dart';
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
const int environmentTableTypeId = 6;
const String environmentTableName = 'environments';
const int attachmentTableTypeId = 7;
const String attachmentTableName = 'attachments';

late final Box<ClientData> clientBox;
late final Box<SupplierData> supplierBox;
late final Box<ItemData> itemBox;
late final Box<EnvironmentData> environmentBox;
late final Box<CompanyData> companyBox;
late final Box<AttachmentData> attachmentBox;

Future<void> databaseConfiguration() async {
  await Hive.initFlutter();
  Hive.registerAdapter<ClientData>(ClientDataAdapter());
  clientBox = await Hive.openBox<ClientData>(clientTableName);
  Hive.registerAdapter<SupplierData>(SupplierDataAdapter());
  supplierBox = await Hive.openBox<SupplierData>(supplierTableName);
  Hive.registerAdapter<ItemData>(ItemDataAdapter());
  itemBox = await Hive.openBox<ItemData>(itemTableName);
  Hive.registerAdapter<EnvironmentData>(EnvironmentDataAdapter());
  environmentBox = await Hive.openBox<EnvironmentData>(environmentTableName);
  Hive.registerAdapter<CompanyData>(CompanyDataAdapter());
  companyBox = await Hive.openBox<CompanyData>(companyTableName);
  Hive.registerAdapter<AttachmentData>(AttachmentDataAdapter());
  attachmentBox = await Hive.openBox<AttachmentData>(attachmentTableName);
}