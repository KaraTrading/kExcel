import 'package:flutter/material.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/feature/client/client_bloc.dart';
import 'package:kexcel/presenter/feature/client/client_bloc_event.dart';
import 'package:kexcel/presenter/utils/excel_utils.dart';
import 'package:kexcel/presenter/utils/text_styles.dart';
import 'package:kexcel/presenter/widget/app_modal_bottom_sheet.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';

class ClientScreen extends BaseScreen<ClientBloc> {
  const ClientScreen({super.key});

  @override
  AppBar? get appBar => AppBar(
        title: const Text('Clients Management'),
        actions: [
          IconButton(
            tooltip: 'Import From Excel',
            onPressed: () => _import(),
            icon: const Icon(
              Icons.input_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          IconButton(
            tooltip: 'Export To Excel',
            onPressed: () => _export(),
            icon: const Icon(
              Icons.output_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      );

  @override
  Widget screenBody(BuildContext context) {
    callEvent(ClientEventInit());
    return DataLoadBlocBuilder<ClientBloc, List<ClientEntity>?>(
      noDataView: const NoItemWidget(),
      bloc: getBloc,
      builder: (BuildContext context, List<ClientEntity>? entities) {
        return ListView.builder(
          itemCount: entities?.length ?? 0,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${entities?[index].code ?? ''} Name: ${entities?[index].name ?? ''}',
                            softWrap: true,
                            maxLines: 2,
                            style: primaryTextStyle.large,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Address: ${entities?[index].address ?? ''}',
                            softWrap: true,
                            maxLines: 2,
                            style: primaryTextStyle.medium,
                          ),
                          const SizedBox(height: 10),
                          FittedBox(
                            child: Text(
                              'BAFA ID: ${entities?[index].bafaId ?? ''}',
                              style: captionTextStyle.medium,
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              'BAFA Email: ${entities?[index].bafaEmail ?? ''}',
                              style: captionTextStyle.medium,
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              'BAFA Site: ${entities?[index].bafaSite ?? ''}',
                              style: captionTextStyle.medium,
                            ),
                          ),
                          const SizedBox(height: 10),
                          FittedBox(
                            child: Text(
                              'National ID: ${entities?[index].nationalId ?? ''}',
                              style: captionTextStyle.medium,
                            ),
                          ),
                          const SizedBox(height: 10),
                          FittedBox(
                            child: Text(
                              'Bank: ${entities?[index].bank ?? ''}',
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              'Contact: ${entities?[index].contact ?? ''}',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Flex(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      direction: Axis.vertical,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => _showClientDetails(context,
                              entity: entities?[index]),
                          child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5)),
                              ),
                              height: 112,
                              child: const Center(
                                  child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ))),
                        ),
                        GestureDetector(
                          onTap: () => _showDeleteConfirmation(
                              context, entities![index]),
                          child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5)),
                              ),
                              height: 112,
                              child: const Center(
                                  child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  FloatingActionButton? floatingActionButton(BuildContext context) =>
      FloatingActionButton(
        onPressed: () => _showClientDetails(context),
        child: const Icon(Icons.add),
      );

  void _showClientDetails(BuildContext context, {ClientEntity? entity}) {
    String newCode = 'C000';
    if (getBloc.clients.isNotEmpty) {
      try {
        newCode =
            'C${((int.tryParse((getBloc.clients.last.code).substring(1)) ?? -1) + 1).toString().padLeft(3, "0")}';
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
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Code',
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: addressController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Address',
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: bafaIdController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'BAFA ID',
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: bafaEmailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'BAFA Email',
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: bafaSiteController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'BAFA Site',
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: nationalIdController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'National ID',
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: bankController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Bank',
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: contactController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Contact',
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
            child: const SizedBox(
              width: double.infinity,
              height: 50,
              child: Center(child: Text('Save')),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  void _export() async {
    exportListToFile(
      [
        'ID',
        'Code',
        'Name',
        'Address',
        'National ID',
        'BAFA ID',
        'BAFA Email',
        'BAFA Site',
        'Contact',
        'Bank',
      ],
      getBloc.clients
          .map(
            (e) => [
              e.id.toString(),
              e.code,
              e.name,
              e.address,
              e.nationalId,
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

  void _import() async {
    final importedData = await importFromFile();

    List<ClientEntity> clients = [];

    if (importedData != null && importedData.length > 1) {
      for (int i = 0; i < importedData.length; i++) {
        if (i == 0 || importedData[i] == null) {
        } else {
          final item = importedData[i];
          if (item?[1] == null || item?[1]?.isEmpty == true) {
            break;
          }
          clients.add(ClientEntity(
            id: 0,
            name: item?[1] ?? '',
            code: item?[0] ?? '',
            address: item?[2],
            nationalId: item?[3],
            // : item?[2],
            bafaEmail: item?[4],
            bafaSite: item?[5],
            bafaId: item?[6],
            contact: item?[7],
            bank: item?[8],
          ));
        }
      }
    }
    callEvent(ClientEventImport(clients));
  }

  void _showDeleteConfirmation(BuildContext context, ClientEntity entity) {
    showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('You can not return deleted item, Are you sure?'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.grey),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.redAccent),
                    ),
                    onPressed: () {
                      callEvent(ClientEventDelete(entity));
                      Navigator.pop(context);
                    },
                    child: const Text('Delete'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
