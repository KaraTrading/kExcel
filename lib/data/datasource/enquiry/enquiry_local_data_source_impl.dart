import 'package:injectable/injectable.dart';
import 'package:kexcel/data/datasource/project/project_local_data_source.dart';
import 'package:kexcel/data/local/model/client_data.dart';
import 'package:kexcel/data/local/model/item_data.dart';
import 'package:kexcel/data/local/model/enquiry_data.dart';
import 'package:kexcel/data/local/model/supplier_data.dart';
import 'package:kexcel/data/local/database.dart';
import 'package:kexcel/domain/entity/enquiry_entity.dart';
import 'enquiry_local_data_source.dart';

@Injectable(as: EnquiryLocalDataSource)
class ProjectLocalDataSourceImpl extends EnquiryLocalDataSource {

  @override
  Database<EnquiryData> storage;

  Database<ClientData> clientStorage;
  Database<SupplierData> supplierStorage;
  Database<ItemData> itemsStorage;
  ProjectLocalDataSource projectsLocalDataSource;

  ProjectLocalDataSourceImpl({
    required this.storage,
    required this.clientStorage,
    required this.supplierStorage,
    required this.itemsStorage,
    required this.projectsLocalDataSource,
  });

  @override
  Future<List<EnquiryEntity>?> getEnquiries(String? search) async {
    final List<EnquiryData>? data;
    if (search == null || search.isEmpty) {
      data = await storage.getAll();
    } else {
      data = await storage.findAll(search);
    }
    final List<EnquiryEntity> all = [];

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
  Future<int> saveEnquiry(EnquiryEntity entity) async {
    final all = await getEnquiries(null);
    final List<EnquiryEntity> allInYear = [];
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
    if (res == null) {
      return -1;
    }
    entity.project.enquiriesIds.add(res.id);
    projectsLocalDataSource.updateProject(entity.project);
    return res.id;
  }

  @override
  Future<bool?> updateEnquiry(EnquiryEntity entity) async {
    final res = await storage.put(entity.mapToData);
    return (res?.id ?? 0) > 0;
  }

  @override
  Future<EnquiryEntity?> getEnquiry(int id) async {
    final data = await storage.getById(id);
    if (data != null) {
      return dataToEntity(data);
    } else {
      return null;
    }
  }

  Future<EnquiryEntity?> dataToEntity(EnquiryData data) async {
    final entity = data.mapToEntity;

    final project = (await projectsLocalDataSource.getProject(data.projectId));
    if (project == null) {
      deleteEnquiry(entity);
      return null;
    }
    entity.project = project;

    if (data.supplierId != null) {
      entity.supplier = (await supplierStorage.getById(data.supplierId!))?.mapToEntity;
    }

    entity.items = [];
    for (var itemId in data.itemsIds) {
      for (var pItem in entity.project.items) {
        if (pItem.item.id == itemId) {
          entity.items.add(pItem);
          break;
        }
      }
    }
    return entity;
  }

  @override
  Future<bool?> deleteEnquiry(EnquiryEntity entity) async {
    return await storage.delete(entity.mapToData);
  }

  @override
  Future<bool?> saveEnquiries(List<EnquiryEntity> entities) async {
    await storage.deleteAll();
    bool allAdded = true;
    for (var element in entities) {
      final added = await saveEnquiry(element);
      if (added < 0) allAdded = false;
    }
    return allAdded;
  }
}
