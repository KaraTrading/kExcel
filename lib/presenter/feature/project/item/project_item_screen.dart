import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';
import 'package:open_file/open_file.dart';
import 'project_item_bloc.dart';
import 'project_item_bloc_event.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xl;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

class ProjectItemScreen extends BaseScreen<ProjectItemBloc> {
  const ProjectItemScreen({super.key});

  @override
  AppBar? get appBar => AppBar(
        title: const Text('ProjectItem Management'),
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
    callEvent(ProjectItemEventInit());
    return DataLoadBlocBuilder<ProjectItemBloc, List<ProjectItemEntity>?>(
      noDataView: const NoItemWidget(),
      bloc: getBloc,
      builder: (BuildContext context, List<ProjectItemEntity>? entities) {
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
                          Text('Id: ${entities?[index].id ?? ''}'),
                          Text('Name: ${entities?[index].name ?? ''}'),
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

  void showClientDetails(BuildContext context, {ProjectItemEntity? entity}) {
    final TextEditingController nameController =
        TextEditingController(text: entity?.name ?? '');

    ClientEntity? client = entity?.client;
    SupplierEntity? winner = entity?.winner;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 25),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
              ),
              const SizedBox(height: 25),
              InputDecorator(
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                  border: OutlineInputBorder(gapPadding: 1),
                  hintText: "Client..",
                ),
                child: Autocomplete(
                  onSelected: (ClientEntity entity) => client = entity,
                  displayStringForOption: (ClientEntity entity) => entity.name,
                  initialValue: TextEditingValue(text: client?.name ?? ''),
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    return getBloc.clients
                        .where(
                          (ClientEntity entity) =>
                              (entity.name.toLowerCase().contains(
                                        textEditingValue.text.toLowerCase(),
                                      ) ||
                                  entity.code.toLowerCase().contains(
                                        textEditingValue.text.toLowerCase(),
                                      )),
                        )
                        .toList();
                  },
                ),
              ),
              const SizedBox(height: 25),
              InputDecorator(
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                  border: OutlineInputBorder(gapPadding: 1),
                  hintText: "Winner..",
                ),
                child: Autocomplete(
                  onSelected: (SupplierEntity entity) => winner = entity,
                  displayStringForOption: (SupplierEntity entity) =>
                      entity.name,
                  initialValue: TextEditingValue(text: winner?.name ?? ''),
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    return getBloc.suppliers
                        .where(
                          (SupplierEntity entity) =>
                              (entity.name.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase(),
                                  )),
                        )
                        .toList();
                  },
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                  onPressed: () {
                    final newEntity = ProjectItemEntity(
                      projectId: 0,
                      id: entity?.id ?? -1,
                      client: client,
                      winner: winner,
                      name: nameController.text,
                      karaProjectNumber: 0,
                    );
                    if (entity == null) {
                      callEvent(ProjectItemEventAddingDone(newEntity));
                    } else {
                      callEvent(ProjectItemEventEditingDone(newEntity));
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

    sheet.getRangeByIndex(1, 1).setText('Project ID');
    sheet.getRangeByIndex(1, 2).setText('ID');
    sheet.getRangeByIndex(1, 3).setText('Name');
    sheet.getRangeByIndex(1, 4).setText('Kara Proj ID');
    sheet.getRangeByIndex(1, 5).setText('Client Id');
    sheet.getRangeByIndex(1, 6).setText('Client Name');
    sheet.getRangeByIndex(1, 7).setText('Winner Id');
    sheet.getRangeByIndex(1, 8).setText('Winner Name');
    sheet.getRangeByIndex(1, 9).setText('Kara PI Value');
    sheet.getRangeByIndex(1, 10).setText('Cancelled');
    sheet.getRangeByIndex(1, 11).setText('Delivery Date');

    for (int i = 0; i < getBloc.projectsItems.length; i++) {
      final item = getBloc.projectsItems[i];
      sheet.getRangeByIndex(i + 2, 1).setText(item.projectId.toString());
      sheet.getRangeByIndex(i + 2, 2).setText(item.id.toString());
      sheet.getRangeByIndex(i + 2, 3).setText(item.name);
      sheet.getRangeByIndex(i + 2, 4).setText(item.karaProjectNumber.toString());
      sheet.getRangeByIndex(i + 2, 5).setText(item.client?.id.toString());
      sheet.getRangeByIndex(i + 2, 6).setText(item.client?.name);
      sheet.getRangeByIndex(i + 2, 7).setText(item.winner?.id.toString());
      sheet.getRangeByIndex(i + 2, 8).setText(item.winner?.name);
      sheet.getRangeByIndex(i + 2, 9).setNumber(item.karaPiValue);
      sheet.getRangeByIndex(i + 2, 10).setText(item.isCancelled ? 'True' : 'False');
      sheet.getRangeByIndex(i + 2, 11).setText(item.deliveryDate?.toIso8601String());
    }
    final List<int> bytes = workbook.saveAsStream();
    final directory = await getApplicationDocumentsDirectory();
    final file = await File('${directory.path}/export_projects_items.xlsx').writeAsBytes(bytes);
    //Dispose the workbook.
    workbook.dispose();

    OpenFile.open(file.path);

  }
}
