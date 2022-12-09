import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/entity/logistic_entity.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'client_data.dart';
import 'logistic_data.dart';
import 'project_item_data.dart';
import 'supplier_data.dart';

extension ClientDataMapper on ClientData {
  ClientEntity get mapToEntity => ClientEntity(
        id: id,
        name: name,
        code: code,
        nationalId: nationalId,
        symbol: symbol,
        address: address,
        bafaId: bafaId,
        bafaEmail: bafaEmail,
        bafaSite: bafaSite,
        contact: contact,
        bank: bank,
      );
}

extension ClientEntityMapper on ClientEntity {
  ClientData get mapToData => ClientData(
        id: id,
        name: name,
        code: code,
        nationalId: nationalId,
        symbol: symbol,
        address: address,
        bafaId: bafaId,
        bafaEmail: bafaEmail,
        bafaSite: bafaSite,
        contact: contact,
        bank: bank,
      );
}

extension SupplierDataMapper on SupplierData {
  SupplierEntity get mapToEntity => SupplierEntity(
        id: id,
        code: code ?? '',
        name: name,
        address: address,
        symbol: symbol,
        vatId: vatId,
      );
}

extension SupplierEntityMapper on SupplierEntity {
  SupplierData get mapToData => SupplierData(
        id: id,
        code: code,
        name: name,
        address: address,
        symbol: symbol,
        vatId: vatId,
      );
}

extension LogisticDataMapper on LogisticData {
  LogisticEntity get mapToEntity => LogisticEntity(id: id, name: name);
}

extension LogisticEntityMapper on LogisticEntity {
  LogisticData get mapToData => LogisticData(name: name);
}

extension ProjectItemDataMapper on ProjectItemData {
  ProjectItemEntity get mapToEntity => ProjectItemEntity(
        projectId: projectId,
        id: id,
        name: name,
        client: null,
        karaProjectNumber: karaProjectNumber,
        winner: null,
        logisticEntity: null,
        isCancelled: isCancelled,
        karaPiValue: karaPiValue,
        deliveryDate: deliveryDate,
      );
}

extension ProjectItemEntityMapper on ProjectItemEntity {
  ProjectItemData get mapToData => ProjectItemData(
        projectId: projectId,
        name: name,
        clientId: client!.id,
        karaProjectNumber: karaProjectNumber,
        winnerId: winner?.id,
        logisticId: logisticEntity?.id,
        isCancelled: isCancelled,
        karaPiValue: karaPiValue,
        deliveryDate: deliveryDate,
      );
}
