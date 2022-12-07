import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/feature/client/client_bloc.dart';
import 'package:kexcel/presenter/feature/client/client_bloc_event.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xl;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

class ClientScreen extends BaseScreen<ClientBloc> {
  const ClientScreen({super.key});

  @override
  AppBar? get appBar => AppBar(
        title: const Text('Client Management'),
        actions: [
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
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Code: ${entities?[index].code ?? ''}'),
                          Text('Name: ${entities?[index].name ?? ''}'),
                          Text('Address: ${entities?[index].address ?? ''}'),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('BAFA ID: ${entities?[index].bafaId ?? ''}'),
                          Text(
                              'BAFA Email: ${entities?[index].bafaEmail ?? ''}'),
                          Text('BAFA Site: ${entities?[index].bafaSite ?? ''}'),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'National ID: ${entities?[index].nationalId ?? ''}'),
                          Text('Bank: ${entities?[index].bank ?? ''}'),
                          Text('Contact: ${entities?[index].contact ?? ''}'),
                        ],
                      ),
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
                  },
                  child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }

  void _export() async {
    // callEvent(ClientEventExport());

    // Create a new Excel document.
    final xl.Workbook workbook = xl.Workbook();
    // Accessing worksheet via index.
    final xl.Worksheet sheet = workbook.worksheets[0];
    // Add Text.


    sheet.getRangeByIndex(1, 1).setText('ID');
    sheet.getRangeByIndex(1, 2).setText('Code');
    sheet.getRangeByIndex(1, 3).setText('Name');
    sheet.getRangeByIndex(1, 4).setText('Address');
    sheet.getRangeByIndex(1, 5).setText('National ID');
    sheet.getRangeByIndex(1, 6).setText('BAFA ID');
    sheet.getRangeByIndex(1, 7).setText('BAFA Email');
    sheet.getRangeByIndex(1, 8).setText('BAFA Site');
    sheet.getRangeByIndex(1, 9).setText('Contact');
    sheet.getRangeByIndex(1, 10).setText('Bank');

    for (int i = 0; i < getBloc.clients.length; i++) {
      final client = getBloc.clients[i];
      sheet.getRangeByIndex(i + 2, 1).setText(client.id.toString());
      sheet.getRangeByIndex(i + 2, 2).setText(client.code);
      sheet.getRangeByIndex(i + 2, 3).setText(client.name);
      sheet.getRangeByIndex(i + 2, 4).setText(client.address);
      sheet.getRangeByIndex(i + 2, 5).setText(client.nationalId);
      sheet.getRangeByIndex(i + 2, 6).setText(client.bafaId);
      sheet.getRangeByIndex(i + 2, 7).setText(client.bafaEmail);
      sheet.getRangeByIndex(i + 2, 8).setText(client.bafaSite);
      sheet.getRangeByIndex(i + 2, 9).setText(client.contact);
      sheet.getRangeByIndex(i + 2, 10).setText(client.bank);
    }
    final List<int> bytes = workbook.saveAsStream();
    final directory = await getApplicationDocumentsDirectory();
    File('${directory.path}/export_clients.xlsx').writeAsBytes(bytes);
    //Dispose the workbook.
    workbook.dispose();
  }
}
