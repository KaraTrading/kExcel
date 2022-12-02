import '../entity/logistic_entity.dart';
import 'base_repository.dart';

abstract class LogisticRepository extends BaseRepository {

  Future<List<LogisticEntity>?> getLogistics({String? search});

  Future<LogisticEntity?> getLogistic(int id);

  Future<bool?> addLogistic(LogisticEntity client);

}