import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/feature/client/client_bloc.dart';
import 'package:kexcel/presenter/feature/client/client_bloc_event.dart';
import 'package:kexcel/presenter/utils/excel_utils.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';

class ClientScreen extends BaseScreen<ClientBloc> {
  const ClientScreen({super.key});

  @override
  AppBar? get appBar => AppBar(
        title: const Text('Client Management'),
        actions: [
          GestureDetector(
            onTap: () => _import(),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.input_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _export(),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.output_rounded,
                color: Colors.white,
                size: 20,
              ),
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
            return GestureDetector(
              onLongPress: () =>
                  showClientDetails(context, entity: entities?[index]),
              child: Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(child: Text('${entities?[index].code ?? ''} Name: ${entities?[index].name ?? ''}')),
                      const SizedBox(height: 10,),
                      FittedBox(child: Text('Address: ${entities?[index].address ?? ''}')),
                      const SizedBox(height: 10,),
                      FittedBox(child: Text('BAFA ID: ${entities?[index].bafaId ?? ''}')),
                      FittedBox(child: Text('BAFA Email: ${entities?[index].bafaEmail ?? ''}')),
                      FittedBox(child: Text('BAFA Site: ${entities?[index].bafaSite ?? ''}')),
                      FittedBox(child: Text('National ID: ${entities?[index].nationalId ?? ''}')),
                      FittedBox(child: Text('Bank: ${entities?[index].bank ?? ''}')),
                      FittedBox(child: Text('Contact: ${entities?[index].contact ?? ''}')),
                    ],
                  ),
                ),
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
        onPressed: () => showClientDetails(context),
        child: const Icon(Icons.add),
      );

  void showClientDetails(BuildContext context, {ClientEntity? entity}) {
    final TextEditingController codeController =
        TextEditingController(text: entity?.code ?? '');
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

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: codeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Code',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Address',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: bafaIdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'BAFA ID',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: bafaEmailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'BAFA Email',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: bafaSiteController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'BAFA Site',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: nationalIdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'National ID',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: bankController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Bank',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: contactController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Contact',
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
                  child: const Text('Save'))
            ],
          ),
        ),
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
}
