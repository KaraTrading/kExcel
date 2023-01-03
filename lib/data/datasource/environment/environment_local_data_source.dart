import 'package:kexcel/data/datasource/base_local_data_source.dart';
import 'package:kexcel/domain/entity/environment_entity.dart';

import '../../local/model/environment_data.dart';

abstract class EnvironmentLocalDataSource extends BaseLocalDataSource<EnvironmentData> {

  Future<int> saveEnvironment(EnvironmentEntity entity);

  Future<bool?> saveEnvironments(List<EnvironmentEntity> entities);

  Future<bool?> deleteEnvironment(EnvironmentEntity entity);

  Future<bool?> updateEnvironment(EnvironmentEntity entity);

  Future<List<EnvironmentEntity>?> getEnvironments(String? search);

  Future<EnvironmentEntity?> getEnvironment(int id);

  Future<int?> getLatestEnvironmentNumber();

}
