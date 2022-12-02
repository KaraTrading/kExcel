import '../../../domain/entity/logistic_entity.dart';
import '../base_local_data_source.dart';

abstract class LogisticLocalDataSource<T> extends BaseLocalDataSource<T> {

  Future<bool?> saveLogistic(LogisticEntity projectItem);

  Future<LogisticEntity?> getLogisticById(int id);

  Future<List<LogisticEntity>?> getLogistics(String? search);

}
