import 'package:injectable/injectable.dart';
import 'package:kexcel/data/datasource/environment/environment_local_data_source.dart';
import 'package:kexcel/domain/entity/environment_entity.dart';
import 'package:kexcel/domain/repository/environment_repository.dart';


@Injectable(as: EnvironmentRepository)
class EnvironmentRepositoryImpl extends EnvironmentRepository{

  final EnvironmentLocalDataSource localDataSource;
  EnvironmentRepositoryImpl(this.localDataSource);

  @override
  Future<int> addEnvironment(EnvironmentEntity entity) async {
    return await localDataSource.saveEnvironment(entity);
  }

  @override
  Future<bool?> updateEnvironment(EnvironmentEntity entity) async {
    return localDataSource.updateEnvironment(entity);
  }

  @override
  Future<EnvironmentEntity?> getEnvironment(int id) async {
    return localDataSource.getEnvironment(id);
  }

  @override
  Future<List<EnvironmentEntity>?> getEnvironments({int? projectId, String? search}) async {
    return await localDataSource.getEnvironments(search);
  }

  @override
  Future<bool?> addEnvironments(List<EnvironmentEntity> entities) {
    return localDataSource.saveEnvironments(entities);
  }

  @override
  Future<bool?> deleteEnvironment(EnvironmentEntity entity) {
    return localDataSource.deleteEnvironment(entity);
  }

  @override
  Future<int?> getLatestEnvironmentNumber() {
    return localDataSource.getLatestEnvironmentNumber();
  }

}