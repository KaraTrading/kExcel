import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/app_interceptor.dart';
import 'package:kexcel/data/local/database_configuration.dart';
import 'package:kexcel/data/local/model/client_data.dart';
import 'package:kexcel/data/local/model/item_data.dart';
import 'package:kexcel/data/local/model/logistic_data.dart';
import 'package:kexcel/data/local/model/project_item_data.dart';
import 'package:kexcel/data/local/model/supplier_data.dart';
import 'package:kexcel/data/local/database.dart';
import 'package:kexcel/data/local/database_impl.dart';

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
  Database<ClientData> clientStorage() {
    return DatabaseImpl<ClientData>(clientBox);
  }

  @Singleton()
  Database<SupplierData> supplierStorage() {
    return DatabaseImpl<SupplierData>(supplierBox);
  }

  @Singleton()
  Database<LogisticData> logisticStorage() {
    return DatabaseImpl<LogisticData>(logisticBox);
  }

  @Singleton()
  Database<ProjectItemData> projectStorage() {
    return DatabaseImpl<ProjectItemData>(projectItemBox);
  }

  @Singleton()
  Database<ItemData> itemStorage() {
    return DatabaseImpl<ItemData>(itemBox);
  }

  @Singleton()
  FlutterSecureStorage get flutterSecureStorage {
    return const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
  }

// @Singleton()
// GigHttpRequest get getHttpRequest {
//   return HttpRequestDioImpl(
//     dio: getDio,
//   );
// }
}
