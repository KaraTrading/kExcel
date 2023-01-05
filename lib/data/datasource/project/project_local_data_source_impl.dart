import 'package:injectable/injectable.dart';
import 'package:kexcel/data/local/model/client_data.dart';
import 'package:kexcel/data/local/model/item_data.dart';
import 'package:kexcel/data/local/model/project_data.dart';
import 'package:kexcel/data/local/model/supplier_data.dart';
import 'package:kexcel/data/local/database.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'project_local_data_source.dart';

@Injectable(as: ProjectLocalDataSource)
class ProjectLocalDataSourceImpl extends ProjectLocalDataSource {

  @override
  Database<ProjectData> storage;

  Database<ClientData> clientStorage;
  Database<SupplierData> supplierStorage;
  Database<ItemData> itemsStorage;

  ProjectLocalDataSourceImpl({
    required this.storage,
    required this.clientStorage,
    required this.supplierStorage,
    required this.itemsStorage,
  });

  @override
  Future<List<ProjectEntity>?> getProjects(String? search) async {
    final List<ProjectData>? data;
    if (search == null || search.isEmpty) {
      data = await storage.getAll();
    } else {
      data = await storage.findAll(search);
    }
    final List<ProjectEntity> all = [];

    if (data?.isEmpty ?? true) {
      return [];
    }
    for (var singleData in data!) {
      final item = await dataToEntity(singleData);
      if (item != null) {
        all.add(item);
      }
    }
    return all;
  }

  @override
  Future<int> saveProject(ProjectEntity entity) async {
    final all = await getProjects(null);
    final List<ProjectEntity> allInYear = [];
    all?.forEach((element) {
      if (element.date.year == DateTime.now().year) {
        allInYear.add(element);
      }
    });
    if (allInYear.isEmpty) {
      entity.annualId = 1;
    } else {
      allInYear.sort((a, b) => a.annualId.compareTo(b.annualId));
      entity.annualId = allInYear.last.annualId + 1;
    }
    final res = await storage.add(entity.mapToData);
    return res?.id ?? -1;
  }

  @override
  Future<bool?> updateProject(ProjectEntity entity) async {
    final res = await storage.put(entity.mapToData);
    return (res?.id ?? 0) > 0;
  }

  @override
  Future<ProjectEntity?> getProject(int id) async {
    final data = await storage.getById(id);
    if (data != null) {
      return dataToEntity(data);
    } else {
      return null;
    }
  }

  Future<ProjectEntity?> dataToEntity(ProjectData data) async {
    final entity = data.mapToEntity;

    if (data.winnersIds.isNotEmpty) {
      for (var winnerId in data.winnersIds) {
        final winner = (await supplierStorage.getById(winnerId))?.mapToEntity;
        if (winner != null) {
          entity.winners.add(winner);
        }
      }
    }

    final items = (await itemsStorage.getByIds(data.itemsIds))
        ?.map((e) => e.mapToEntity)
        .toList() ??
        [];
    final itemQuantities = data.itemsQuantities;
    final itemDimensions = data.itemsDimensions;
    entity.items = [];
    for (int i = 0; i < items.length; i++) {
      entity.items.add(ProjectItemEntity(
        item: items[i],
        quantity: itemQuantities[i],
        dimension: itemDimensions[i],
      ));
    }
    return entity;
  }

  @override
  Future<bool?> deleteProject(ProjectEntity entity) async {
    return await storage.delete(entity.mapToData);
  }

  @override
  Future<bool?> saveProjects(List<ProjectEntity> entities) async {
    await storage.deleteAll();
    bool allAdded = true;
    for (var element in entities) {
      final added = await saveProject(element);
      if (added < 0) allAdded = false;
    }
    return allAdded;
  }

  @override
  Future<int?> getLatestProjectAnnualId() async {
    return storage.lastKey();
  }
}
