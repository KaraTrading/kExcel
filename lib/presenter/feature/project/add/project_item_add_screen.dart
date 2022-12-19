import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/feature/project/add/project_item_add_bloc.dart';
import 'package:kexcel/presenter/feature/project/add/project_item_add_bloc_event.dart';
import 'package:kexcel/presenter/feature/project/pdf_screen.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';

class ProjectItemAddScreen extends BaseScreen<ProjectItemAddBloc> {
  final ProjectItemEntity? entity;
  const ProjectItemAddScreen({this.entity, super.key});

  @override
  AppBar? get appBar => AppBar();

  @override
  FloatingActionButton? floatingActionButton(BuildContext context) => null;

  @override
  Widget screenBody(BuildContext context) {
    callEvent(ProjectItemAddEventInit());

    final TextEditingController nameController = TextEditingController(text: entity?.name);

    ClientEntity? client = entity?.client;
    SupplierEntity? winner = entity?.winner;

    return DataLoadBlocBuilder<ProjectItemAddBloc, List<ItemEntity>?>(
        noDataView: const NoItemWidget(),
        bloc: getBloc,
        builder: (BuildContext context, List<ItemEntity>? entities) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 4),
                            border: const OutlineInputBorder(gapPadding: 1),
                            labelText: 'client'.translate,
                          ),
                          child: Autocomplete(
                            onSelected: (ClientEntity entity) =>
                                client = entity,
                            displayStringForOption: (ClientEntity entity) =>
                                entity.name,
                            initialValue:
                                TextEditingValue(text: client?.name ?? ''),
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              return getBloc.clients
                                  .where(
                                    (ClientEntity entity) =>
                                        (entity.name.toLowerCase().contains(
                                                  textEditingValue.text
                                                      .toLowerCase(),
                                                ) ||
                                            entity.code.toLowerCase().contains(
                                                  textEditingValue.text
                                                      .toLowerCase(),
                                                )),
                                  )
                                  .toList();
                            },
                          ),
                        ),
                        const SizedBox(height: 25),
                        InputDecorator(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 4),
                            border: const OutlineInputBorder(gapPadding: 1),
                            labelText: 'winner'.translate,
                          ),
                          child: Autocomplete(
                            onSelected: (SupplierEntity entity) =>
                                winner = entity,
                            displayStringForOption: (SupplierEntity entity) =>
                                entity.name,
                            initialValue:
                                TextEditingValue(text: winner?.name ?? ''),
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              return getBloc.suppliers
                                  .where(
                                    (SupplierEntity entity) => (entity.name
                                        .toLowerCase()
                                        .contains(
                                          textEditingValue.text.toLowerCase(),
                                        )),
                                  )
                                  .toList();
                            },
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    final newEntity = ProjectItemEntity(
                      projectId: 0,
                      id: 0,
                      client: client,
                      winner: winner,
                      name: nameController.text,
                      karaProjectNumber: 0,
                    );

                    callEvent(ProjectItemEventAddingDone(newEntity));

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PDFScreen(),
                    ));
                  },
                  child: Text('save'.translate))
            ],
          );
        });
  }
}
