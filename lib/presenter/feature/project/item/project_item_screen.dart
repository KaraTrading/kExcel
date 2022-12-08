import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/utils/excel_utils.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';
import 'project_item_bloc.dart';
import 'project_item_bloc_event.dart';
class ProjectItemScreen extends BaseScreen<ProjectItemBloc> {
  const ProjectItemScreen({super.key});

  @override
  AppBar? get appBar =>
      AppBar(
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
      builder: (context) =>
          Padding(
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
                      displayStringForOption: (ClientEntity entity) =>
                      entity.name,
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
    final titles = [
      'Project ID',
      'ID',
      'Name',
      'Kara Proj ID',
      'Client Id',
      'Client Name',
      'Winner Id',
      'Winner Name',
      'Kara PI Value',
      'Cancelled',
      'Delivery Date',
    ];
    exportListToFile(titles, getBloc.projectsItems.map((e) => [
      e.projectId.toString(),
      e.id.toString(),
      e.name,
      e.karaProjectNumber.toString(),
      e.client?.id.toString(),
      e.client?.name,
      e.winner?.id.toString(),
      e.winner?.name,
      e.karaPiValue?.toString(),
      e.isCancelled ? 'True' : 'False',
      e.deliveryDate?.toIso8601String(),
    ]).toList(), 'exported_projects_items.xlsx');
  }
}
