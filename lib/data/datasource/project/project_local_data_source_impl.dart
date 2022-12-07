import 'package:injectable/injectable.dart';
import 'package:kexcel/data/datasource/project/project_local_data_source.dart';
import 'package:kexcel/data/local/model/client_data.dart';
import 'package:kexcel/data/local/model/logistic_data.dart';
import 'package:kexcel/data/local/model/mapper.dart';
import 'package:kexcel/data/local/model/project_item_data.dart';
import 'package:kexcel/data/local/model/supplier_data.dart';
import 'package:kexcel/data/local/secure_storage.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';

@Injectable(as: ProjectLocalDataSource)
class ProjectLocalDataSourceImpl extends ProjectLocalDataSource {

  @override
  SecureStorage<ProjectItemData> storage;

  SecureStorage<ClientData> clientStorage;
  SecureStorage<SupplierData> supplierStorage;
  SecureStorage<LogisticData> logisticStorage;

  ProjectLocalDataSourceImpl({
    required this.storage,
    required this.clientStorage,
    required this.supplierStorage,
    required this.logisticStorage,
  });

  @override
  Future<List<ProjectItemEntity>?> getProjectsItems(String? search) async {
    final List<ProjectItemData>? allClientData;
    if (search == null || search.isEmpty) {
      allClientData = await storage.getAll();
    } else {
      allClientData = await storage.findAll(search);
    }
    final List<ProjectItemEntity> allClientEntity = [];
    allClientData?.forEach((e) async {
      final item = await projectItemDataToProjectItemEntity(e);
      if (item != null) {
        allClientEntity.add(item);
      }
    });
    return allClientEntity;
  }

  @override
  Future<bool?> saveProjectItem(ProjectItemEntity projectItem) async {
    final res = storage.add(projectItem.mapToData);
    return ((await res)?.id ?? 0) > 0;
  }

  @override
  Future<bool?> updateProjectItem(ProjectItemEntity projectItem) async {
    final res = storage.put(projectItem.mapToData);
    return ((await res)?.id ?? 0) > 0;
  }

  @override
  Future<ProjectItemEntity?> getProjectsItemsById(int id) async {
    final data = await storage.getById(id);
    if (data != null) {
      return projectItemDataToProjectItemEntity(data);
    } else {
      return null;
    }
  }

  Future<ProjectItemEntity?> projectItemDataToProjectItemEntity(
      ProjectItemData data) async {
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
    return entity;
  }
}
