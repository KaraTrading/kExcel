import 'package:injectable/injectable.dart';
import 'package:kexcel/domain/entity/logistic_entity.dart';
import 'package:kexcel/domain/repository/logistic_repository.dart';

@Singleton(as: LogisticRepository)
class ClientRepositoryImpl extends LogisticRepository {

  @override
  Future<bool?> addLogistic(LogisticEntity client) async {
    // TODO: implement addLogistic
    throw UnimplementedError();
  }

  @override
  Future<LogisticEntity?> getLogistic(int id) async {
    // TODO: implement getLogistic
    throw UnimplementedError();
  }

  @override
  Future<List<LogisticEntity>?> getLogistics({String? search}) async {
    // TODO: implement getLogistics
    throw UnimplementedError();
  }


}