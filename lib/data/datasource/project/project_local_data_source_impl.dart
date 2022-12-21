import 'package:injectable/injectable.dart';
import 'package:kexcel/data/datasource/project/project_local_data_source.dart';
import 'package:kexcel/data/local/model/client_data.dart';
import 'package:kexcel/data/local/model/item_data.dart';
import 'package:kexcel/data/local/model/logistic_data.dart';
import 'package:kexcel/data/local/model/project_data.dart';
import 'package:kexcel/data/local/model/supplier_data.dart';
import 'package:kexcel/data/local/database.dart';
import 'package:kexcel/domain/entity/project_entity.dart';

@Injectable(as: ProjectLocalDataSource)
class ProjectLocalDataSourceImpl extends ProjectLocalDataSource {

  @override
  Database<ProjectData> storage;

  Database<ClientData> clientStorage;
  Database<SupplierData> supplierStorage;
  Database<LogisticData> logisticStorage;
  Database<ItemData> itemsStorage;

  ProjectLocalDataSourceImpl({
    required this.storage,
    required this.clientStorage,
    required this.supplierStorage,
    required this.logisticStorage,
    required this.itemsStorage,
  });

  @override
  Future<List<ProjectEntity>?> getProjects(String? search) async {
    final List<ProjectData>? projects;
    if (search == null || search.isEmpty) {
      projects = await storage.getAll();
    } else {
      projects = await storage.findAll(search);
    }
    final List<ProjectEntity> allProjects = [];

    if (projects?.isEmpty ?? true) {
      return [];
    }
    for (var project in projects!) {
      final item = await projectDataToProjectEntity(project);
      if (item != null) {
        allProjects.add(item);
      }
    }
    return allProjects;
  }

  @override
  Future<bool?> saveProject(ProjectEntity entity) async {
    final res = await storage.add(entity.mapToData);
    return (res?.id ?? 0) > 0;
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
      return projectDataToProjectEntity(data);
    } else {
      return null;
    }
  }

  Future<ProjectEntity?> projectDataToProjectEntity(ProjectData data) async {
    final entity = data.mapToEntity;
    entity.client = (await clientStorage.getById(data.clientId))?.mapToEntity;
    if (data.winnerId != null) {
      entity.winner =
          (await supplierStorage.getById(data.winnerId!))?.mapToEntity;
    }
    if (data.logisticId != null) {
      entity.logisticEntity =
          (await logisticStorage.getById(data.logisticId!))?.mapToEntity;
    }
    if (data.itemsIds != null) {
      entity.items = (await itemsStorage.getByIds(data.itemsIds!))?.map((e) => e.mapToEntity).toList() ?? [];
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
      if (added!) allAdded = false;
    }
    return allAdded;
  }

  @override
  Future<int?> getLatestProjectNumber() async {
    final allProjects = await getProjects(null);
    if (allProjects?.isNotEmpty ?? false) {
      return allProjects!.last.id;
    }
    return null;
  }
}
