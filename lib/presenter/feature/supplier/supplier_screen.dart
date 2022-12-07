import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';
import 'supplier_bloc.dart';
import 'supplier_bloc_event.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xl;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

class SupplierScreen extends BaseScreen<SupplierBloc> {
  const SupplierScreen({super.key});

  @override
  AppBar? get appBar => AppBar(
        title: const Text('Supplier Management'),
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
    callEvent(SupplierEventInit());
    return DataLoadBlocBuilder<SupplierBloc, List<SupplierEntity>?>(
      noDataView: const NoItemWidget(),
      bloc: getBloc,
      builder: (BuildContext context, List<SupplierEntity>? entities) {
        return ListView.builder(
          itemCount: entities?.length ?? 0,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () =>
                  showClientDetails(context, entity: entities?[index]),
              child: Card(
                margin: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Id: ${entities?[index].id ?? ''}'),
                            Text('Name: ${entities?[index].name ?? ''}'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5)),
                              ),
                              height: 32,
                              child: const Center(
                                  child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ))),
                          Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5)),
                              ),
                              height: 32,
                              child: const Center(
                                  child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ))),
                        ],
                      ),
                    ),
                  ],
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

  void showClientDetails(BuildContext context, {SupplierEntity? entity}) {
    final TextEditingController nameController =
        TextEditingController(text: entity?.name ?? '');

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
              ElevatedButton(
                  onPressed: () {
                    final newEntity = SupplierEntity(
                      id: entity?.id ?? -1,
                      name: nameController.text,
                    );
                    if (entity == null) {
                      callEvent(SupplierEventAddingDone(newEntity));
                    } else {
                      callEvent(SupplierEventEditingDone(newEntity));
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
    // callEvent(SupplierEventExport());

    // Create a new Excel document.
    final xl.Workbook workbook = xl.Workbook();
    // Accessing worksheet via index.
    final xl.Worksheet sheet = workbook.worksheets[0];
    // Add Text.

    sheet.getRangeByIndex(1, 1).setText('ID');
    sheet.getRangeByIndex(1, 2).setText('Name');
    for (int i = 0; i < getBloc.suppliers.length; i++) {
      final supplier = getBloc.suppliers[i];
      sheet.getRangeByIndex(i + 2, 1).setText(supplier.id.toString());
      sheet.getRangeByIndex(i + 2, 2).setText(supplier.name);
    }
    final List<int> bytes = workbook.saveAsStream();
    final directory = await getApplicationDocumentsDirectory();
    File('${directory.path}/export_suppliers.xlsx').writeAsBytes(bytes);
    //Dispose the workbook.
    workbook.dispose();
  }
}
