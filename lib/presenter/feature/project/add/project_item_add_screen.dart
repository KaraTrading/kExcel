import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/feature/project/add/project_item_add_bloc.dart';
import 'package:kexcel/presenter/feature/project/add/project_item_add_bloc_event.dart';
import 'package:kexcel/presenter/feature/project/pdf_screen.dart';
import 'package:kexcel/presenter/utils/app_colors.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProjectItemAddScreen extends BaseScreen<ProjectItemAddBloc> {
  final ProjectEntity? entity;

  const ProjectItemAddScreen({this.entity, super.key});

  @override
  AppBar? get appBar => AppBar();

  @override
  FloatingActionButton? floatingActionButton(BuildContext context) => null;

  @override
  Widget screenBody(BuildContext context) {
    callEvent(ProjectItemAddEventInit());

    final TextEditingController nameController =
        TextEditingController(text: entity?.name);

    if (entity != null) {
      getBloc.project = entity!;
    } else {
      getBloc.project =
          ProjectEntity(projectId: 0, id: 0, name: '', karaProjectNumber: 0);
    }

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
                                getBloc.project.client = entity,
                            displayStringForOption: (ClientEntity entity) =>
                                entity.name,
                            initialValue: TextEditingValue(
                                text: getBloc.project.client?.name ?? ''),
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
                                getBloc.project.winner = entity,
                            displayStringForOption: (SupplierEntity entity) =>
                                entity.name,
                            initialValue: TextEditingValue(
                                text: getBloc.project.winner?.name ?? ''),
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
                        StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) =>
                                  Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: colorGrey,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                MultiSelectBottomSheetField<ItemEntity?>(
                                  initialValue: getBloc.project.items ?? [],
                                  initialChildSize: 0.4,
                                  listType: MultiSelectListType.LIST,
                                  searchable: true,
                                  buttonText: const Text("Selected Items"),
                                  title: const Text("Items"),
                                  onSelectionChanged: (values) {
                                    setState(() {
                                      getBloc.project.items = values.cast<ItemEntity>();
                                    });
                                  },
                                  items: getBloc.items
                                      .map((e) => MultiSelectItem(e, e.name))
                                      .toList(),
                                  onConfirm: (values) {
                                    setState(() {
                                      getBloc.project.items = values.cast<ItemEntity>();
                                    });
                                  },
                                  chipDisplay: MultiSelectChipDisplay(
                                    // onTap: (value) {
                                    //   setState(() {
                                    //     getBloc.selectedItems.remove(value);
                                    //   });
                                    // },
                                  ),
                                ),
                                getBloc.project.items == null ||
                                        getBloc.project.items!.isEmpty
                                    ? Container(
                                        padding: const EdgeInsets.all(10),
                                        alignment: Alignment.centerLeft,
                                        child: const Text(
                                          "None selected",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ))
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: ElevatedButton(
                    onPressed: () {
                      getBloc.project.name = nameController.text;
                      callEvent(ProjectItemEventAddingDone());

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PDFScreen(
                            project: getBloc.project,
                            user: getBloc.user,
                            company: getBloc.company),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('save'.translate),
                    )),
              )
            ],
          );
        });
  }
}
