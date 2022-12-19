import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:kexcel/core/app_interceptor.dart';
import 'package:kexcel/data/local/database_configuration.dart';
import 'package:kexcel/data/local/model/client_data.dart';
import 'package:kexcel/data/local/model/company_data.dart';
import 'package:kexcel/data/local/model/item_data.dart';
import 'package:kexcel/data/local/model/logistic_data.dart';
import 'package:kexcel/data/local/model/project_data.dart';
import 'package:kexcel/data/local/model/supplier_data.dart';
import 'package:kexcel/data/local/database.dart';
import 'package:kexcel/data/local/database_impl.dart';
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
  Database<ProjectData> projectStorage() {
    return DatabaseImpl<ProjectData>(projectBox);
  }

  @Singleton()
  Database<ItemData> itemStorage() {
    return DatabaseImpl<ItemData>(itemBox);
  }

  @Singleton()
  Database<CompanyData> companyStorage() {
    return DatabaseImpl<CompanyData>(companyBox);
  }

  @Singleton()
  SecureStorage get secureStorage => SecureStorageImpl(
        const FlutterSecureStorage(
          iOptions: IOSOptions(
            accessibility: KeychainAccessibility.first_unlock,
          ),
          mOptions: MacOsOptions(
            accessibility: KeychainAccessibility.first_unlock,
          ),
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
        ),
      );

// @Singleton()
// GigHttpRequest get getHttpRequest {
//   return HttpRequestDioImpl(
//     dio: getDio,
//   );
// }
}
