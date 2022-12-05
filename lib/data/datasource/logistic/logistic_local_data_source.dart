import '../../../domain/entity/logistic_entity.dart';
import '../../local/model/logistic_data.dart';
import '../base_local_data_source.dart';

abstract class LogisticLocalDataSource extends BaseLocalDataSource<LogisticData> {

  Future<bool?> saveLogistic(LogisticEntity projectItem);

  Future<LogisticEntity?> getLogisticById(int id);

  Future<List<LogisticEntity>?> getLogistics(String? search);

}
