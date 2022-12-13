import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/app_interceptor.dart';
import 'package:kexcel/data/local/database_configuration.dart';
import 'package:kexcel/data/local/model/client_data.dart';
import 'package:kexcel/data/local/model/item_data.dart';
import 'package:kexcel/data/local/model/logistic_data.dart';
import 'package:kexcel/data/local/model/project_item_data.dart';
import 'package:kexcel/data/local/model/supplier_data.dart';
import 'package:kexcel/data/local/secure_storage.dart';
import 'package:kexcel/data/local/secure_storage_impl.dart';

@module
abstract class RegisterModule {
  ///provide dio network
  ///
  @Singleton()
  Dio get getDio {
    var dio = Dio();
    dio.interceptors.add(AppDioInterceptor(dio: dio));
    return dio;
  }

  @Singleton()
  SecureStorage<ClientData> clientStorage() {
    return SecureStorageImpl<ClientData>(clientBox);
  }

  @Singleton()
  SecureStorage<SupplierData> supplierStorage() {
    return SecureStorageImpl<SupplierData>(supplierBox);
  }

  @Singleton()
  SecureStorage<LogisticData> logisticStorage() {
    return SecureStorageImpl<LogisticData>(logisticBox);
  }

  @Singleton()
  SecureStorage<ProjectItemData> projectStorage() {
    return SecureStorageImpl<ProjectItemData>(projectItemBox);
  }

  @Singleton()
  SecureStorage<ItemData> itemStorage() {
    return SecureStorageImpl<ItemData>(itemBox);
  }

// @Singleton()
// GigHttpRequest get getHttpRequest {
//   return HttpRequestDioImpl(
//     dio: getDio,
//   );
// }
}
