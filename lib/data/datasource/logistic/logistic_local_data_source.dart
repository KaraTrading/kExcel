import 'package:injectable/injectable.dart';
import '../../../domain/entity/logistic_entity.dart';
import '../base_local_data_source.dart';

@Singleton()
abstract class LogisticLocalDataSource extends BaseLocalDataSource {
  LogisticLocalDataSource(super.tableName);


  Future<bool?> saveLogistic(LogisticEntity projectItem);

  Future<LogisticEntity?> getLogisticById(int id);

  Future<List<LogisticEntity>?> getLogistics(String? search);

}
