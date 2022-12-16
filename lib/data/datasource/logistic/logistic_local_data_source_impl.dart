import 'package:injectable/injectable.dart';
import 'package:kexcel/data/datasource/logistic/logistic_local_data_source.dart';
import 'package:kexcel/data/local/model/logistic_data.dart';
import 'package:kexcel/data/local/database.dart';
import 'package:kexcel/domain/entity/logistic_entity.dart';

@Injectable(as: LogisticLocalDataSource)
class LogisticLocalDataSourceImpl extends LogisticLocalDataSource {

  @override
  Database<LogisticData> storage;

  LogisticLocalDataSourceImpl(this.storage);

  @override
  Future<List<LogisticEntity>?> getLogistics(String? search) async {
    if (search == null || search.isEmpty) {
      final allClientData = await storage.getAll();
      final allClientEntity = allClientData?.map((e) => e.mapToEntity).toList();
      return Future.value(allClientEntity);
    } else {
      final allClientData = await storage.findAll(search);
      final allClientEntity = allClientData?.map((e) => e.mapToEntity).toList();
      return Future.value(allClientEntity);
    }
  }

  @override
  Future<bool?> saveLogistic(LogisticEntity projectItem) async {
    final res = await storage.add(projectItem.mapToData);
    return (res?.id ?? 0) > 0;
  }

  @override
  Future<LogisticEntity?> getLogisticById(int id) async {
    return (await storage.getById(id))?.mapToEntity;
  }

}