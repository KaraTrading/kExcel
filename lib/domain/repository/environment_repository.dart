import 'base_repository.dart';
import '../entity/environment_entity.dart';

abstract class EnvironmentRepository extends BaseRepository {

  Future<List<EnvironmentEntity>?> getEnvironments({
    int? projectId,
    String? search,
  });

  Future<EnvironmentEntity?> getEnvironment(int id);

  Future<int> addEnvironment(EnvironmentEntity entity);

  Future<bool?> addEnvironments(List<EnvironmentEntity> entities);

  Future<bool?> deleteEnvironment(EnvironmentEntity entity);

  Future<bool?> updateEnvironment(EnvironmentEntity entity);
}
