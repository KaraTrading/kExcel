import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/feature/information/base_information_screen.dart';
import 'package:kexcel/presenter/utils/excel_utils.dart';
import 'project_item_bloc.dart';
import 'project_item_bloc_event.dart';

class ProjectItemScreen extends BaseInformationScreen<ProjectItemBloc, ProjectItemEntity> {
  const ProjectItemScreen({super.key});

  @override
  AppBar? get appBar => AppBar(
    title: Text(title),
    actions: [
      IconButton(
        tooltip: 'exportToExcel'.translate,
        onPressed: () => export(),
        icon: const Icon(
          Icons.output_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
    ],
  );

  @override
  String get title => 'projectsItemsManagement'.translate;

  @override
  BaseBlocEvent get initEvent => callEvent(ProjectItemEventInit());

  @override
  BaseBlocEvent deleteEvent(ProjectItemEntity entity) => callEvent(ProjectItemEventDelete(entity));

  @override
  Widget itemDetails(ProjectItemEntity entity) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${'id'.translate}: ${entity.id ?? ''}'),
            Text('${'name'.translate}: ${entity.name ?? ''}'),
          ],
        ),
      ],
    );
  }

  @override
  void editItemDetails(BuildContext context, {ProjectItemEntity? entity}) {
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
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'name'.translate,
                    ),
                  ),
                  const SizedBox(height: 25),
                  InputDecorator(
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                      border: const OutlineInputBorder(gapPadding: 1),
                      labelText: 'client'.translate,
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
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                      border: const OutlineInputBorder(gapPadding: 1),
                      labelText: 'winner'.translate,
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
                      child: Text('save'.translate))
                ],
              ),
            ),
          ),
    );
  }

  @override
  void export() {
    final titles = [
      'projectId'.translate,
      'id'.translate,
      'name'.translate,
      'karaProjectId'.translate,
      'clientId'.translate,
      'client'.translate,
      'winnerId'.translate,
      'winner'.translate,
      'karaPiValue'.translate,
      'Cancelled'.translate,
      'deliveryDate'.translate,
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
      e.isCancelled ? 'true'.translate : 'false'.translate,
      e.deliveryDate?.toIso8601String(),
    ]).toList(), 'exported_projects_items.xlsx');
  }

  @override
  void import() {

  }
}
