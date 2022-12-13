import 'package:flutter/material.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/feature/information/base_information_screen.dart';
import 'package:kexcel/presenter/utils/excel_utils.dart';
import 'package:kexcel/presenter/utils/text_styles.dart';
import 'package:kexcel/presenter/widget/app_modal_bottom_sheet.dart';
import 'client_bloc.dart';
import 'client_bloc_event.dart';

class ClientScreen extends BaseInformationScreen<ClientBloc, ClientEntity> {
  const ClientScreen({super.key});

  @override
  BaseBlocEvent deleteEvent(ClientEntity entity) => ClientEventDelete(entity);

  @override
  BaseBlocEvent get initEvent => ClientEventInit();

  @override
  String get title => 'clientsManagement'.translate;

  @override
  void editItemDetails(BuildContext context, {ClientEntity? entity}) {
    String newCode = 'C000';
    if (getBloc.clients.isNotEmpty) {
      try {
        newCode =
        'C${((int.tryParse((getBloc.clients.last.code).substring(1)) ?? -1) + 1)
            .toString()
            .padLeft(3, "0")}';
      } on BaseException {
        newCode = '';
      }
    }

    final TextEditingController codeController =
    TextEditingController(text: entity?.code ?? newCode);
    final TextEditingController nameController =
    TextEditingController(text: entity?.name ?? '');
    final TextEditingController addressController =
    TextEditingController(text: entity?.address ?? '');
    final TextEditingController nationalIdController =
    TextEditingController(text: entity?.nationalId ?? '');
    final TextEditingController symbolController =
    TextEditingController(text: entity?.symbol ?? '');
    final TextEditingController bafaIdController =
    TextEditingController(text: entity?.bafaId ?? '');
    final TextEditingController bafaEmailController =
    TextEditingController(text: entity?.bafaEmail ?? '');
    final TextEditingController bafaSiteController =
    TextEditingController(text: entity?.bafaSite ?? '');
    final TextEditingController bankController =
    TextEditingController(text: entity?.bank ?? '');
    final TextEditingController contactController =
    TextEditingController(text: entity?.contact ?? '');

    showAppBottomSheet(
      isDismissible: false,
      enableDrag: false,
      showCloseIcon: true,
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: codeController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'code'.translate,
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'name'.translate,
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'address'.translate,
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: nationalIdController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'nationalId'.translate,
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: symbolController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'symbol'.translate,
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: bafaIdController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'bafaId'.translate,
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: bafaEmailController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'bafaEmail'.translate,
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: bafaSiteController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'bafaSite'.translate,
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: bankController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'bank'.translate,
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: contactController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'contact'.translate,
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              final newEntity = ClientEntity(
                id: entity?.id ?? -1,
                name: nameController.text,
                code: codeController.text,
                nationalId: nationalIdController.text,
                symbol: symbolController.text,
                address: addressController.text,
                bafaId: bafaIdController.text,
                bafaEmail: bafaEmailController.text,
                bafaSite: bafaSiteController.text,
                bank: bankController.text,
                contact: contactController.text,
              );
              if (entity == null) {
                callEvent(ClientEventAddingDone(newEntity));
              } else {
                callEvent(ClientEventEditingDone(newEntity));
              }
              Navigator.pop(context);
            },
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: Center(child: Text('save'.translate)),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  @override
  void export() async {
    exportListToFile(
      [
        'id'.translate,
        'code'.translate,
        'name'.translate,
        'address'.translate,
        'nationalId'.translate,
        'symbol'.translate,
        'bafId'.translate,
        'bafEmail'.translate,
        'bafaSite'.translate,
        'contact'.translate,
        'bank'.translate,
      ],
      getBloc.clients
          .map(
            (e) =>
        [
          e.id.toString(),
          e.code,
          e.name,
          e.address,
          e.nationalId,
          e.symbol,
          e.bafaId,
          e.bafaEmail,
          e.bafaSite,
          e.contact,
          e.bank,
        ],
      )
          .toList(),
      'export_clients.xlsx',
    );
  }

  @override
  void import() async {
    final importedData = await importFromFile();

    List<ClientEntity> clients = [];

    if (importedData != null && importedData.length > 1) {
      for (int i = 0; i < importedData.length; i++) {
        if (i == 0 || importedData[i] == null) {} else {
          final item = importedData[i];
          if (item?[1] == null || item?[1]?.isEmpty == true) {
            break;
          }
          clients.add(ClientEntity(
            id: 0,
            code: item?[0] ?? '',
            name: item?[1] ?? '',
            address: item?[2],
            nationalId: item?[3],
            symbol: item?[4],
            bafaEmail: item?[5],
            bafaSite: item?[6],
            bafaId: item?[7],
            contact: item?[8],
            bank: item?[9],
          ));
        }
      }
    }
    callEvent(ClientEventImport(clients));
  }

  @override
  Widget itemDetails(ClientEntity entity) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${entity.code} ${entity.name}',
          softWrap: true,
          maxLines: 2,
          style: primaryTextStyle.large,
        ),
        const SizedBox(height: 10),
        FittedBox(
          child: Text(
            '${'nationalId'.translate}: ${entity.nationalId ?? ''}',
            style: captionTextStyle.medium,
          ),
        ),
        const SizedBox(height: 10),
        FittedBox(
          child: Text(
            '${'symbol'.translate}: ${entity.symbol ?? ''}',
            style: captionTextStyle.medium,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${'address'.translate}: ${entity.address ?? ''}',
          softWrap: true,
          maxLines: 2,
          style: primaryTextStyle.medium,
        ),
        const SizedBox(height: 10),
        FittedBox(
          child: Text(
            '${'bafaId'.translate}: ${entity.bafaId ?? ''}',
            style: captionTextStyle.medium,
          ),
        ),
        FittedBox(
          child: Text(
            '${'bafaEmail'.translate}: ${entity.bafaEmail ?? ''}',
            style: captionTextStyle.medium,
          ),
        ),
        FittedBox(
          child: Text(
            '${'bafaSite'.translate}: ${entity.bafaSite ?? ''}',
            style: captionTextStyle.medium,
          ),
        ),
        const SizedBox(height: 10),
        FittedBox(child: Text('${'bank'.translate}: ${entity.bank ?? ''}')),
        FittedBox(child: Text('${'contact'.translate}: ${entity.contact ?? ''}')),
      ],
    );
  }
}
