import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/feature/project/add/project_add_bloc.dart';
import 'package:kexcel/presenter/feature/project/add/project_add_bloc_event.dart';
import 'package:kexcel/presenter/feature/project/pdf_screen.dart';
import 'package:kexcel/presenter/utils/app_colors.dart';
import 'package:kexcel/presenter/utils/text_styles.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProjectAddScreen extends BaseScreen<ProjectAddBloc> {
  final ProjectEntity? entity;

  const ProjectAddScreen({this.entity, super.key});

  @override
  AppBar? get appBar => AppBar();

  @override
  FloatingActionButton? floatingActionButton(BuildContext context) => null;

  @override
  Widget screenBody(BuildContext context) {
    callEvent(ProjectAddEventInit());

    if (getBloc.project == null) {
      if (entity != null) {
        getBloc.project = entity!;
      } else {
        getBloc.project =
            ProjectEntity(projectId: 0, id: 0, name: '', karaProjectNumber: 0);
      }
    }

    final TextEditingController nameController =
    TextEditingController(text: getBloc.project?.name);

    bool isAdvanceOptionsShowing = false;

    final TextEditingController introController = TextEditingController(
        text:
        'Dear Sir/Madame,\nKindly provide us with your best offer for delivering the list items:');

    final TextEditingController outroController = TextEditingController(
        text:
        'The offer is requested in English language. In case of any questions please feel free to contact me at any time.\nBest Regards,');

    final necessaryItems = [
      NecessaryItem(title: 'Our reference', isAvailable: true),
      NecessaryItem(
          title: 'Scope of supply (Description of goods)', isAvailable: true),
      NecessaryItem(title: 'Item price and total price', isAvailable: true),
      NecessaryItem(title: 'Time of delivery', isAvailable: true),
      NecessaryItem(title: 'Terms of delivery', isAvailable: true),
      NecessaryItem(title: 'Packing', isAvailable: true),
      NecessaryItem(
          title: 'Weights: net & gross (estimated at least)',
          isAvailable: true),
      NecessaryItem(title: 'Terms of payment', isAvailable: true),
      NecessaryItem(title: 'Country of origin', isAvailable: true),
      NecessaryItem(
          title: 'Customs tariff number / HS code', isAvailable: true),
      NecessaryItem(title: 'Validity of offer', isAvailable: true),
    ];

    final TextEditingController termsOfDeliveryExtraDataController =
    TextEditingController(text: necessaryItems[4].extraData);
    final TextEditingController packingExtraDataController =
    TextEditingController(text: necessaryItems[5].extraData);
    final TextEditingController termsOfPaymentExtraDataController =
    TextEditingController(text: necessaryItems[7].extraData);

    void updateProject() {
      callEvent(ProjectAddEventUpdatedProject());
      Future.delayed(const Duration(milliseconds: 50), () {
        nameController.text = getBloc.project!.name;
      });
    }

    return DataLoadBlocBuilder<ProjectAddBloc, List<ItemEntity>?>(
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
                            onSelected: (ClientEntity entity) {
                              getBloc.project!.client = entity;
                              updateProject();
                            },
                            displayStringForOption: (ClientEntity entity) =>
                            entity.name,
                            initialValue: TextEditingValue(
                                text: getBloc.project!.client?.name ?? ''),
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
                            onSelected: (SupplierEntity entity) {
                              getBloc.project!.winner = entity;
                              updateProject();
                            },
                            displayStringForOption: (SupplierEntity entity) =>
                            entity.name,
                            initialValue: TextEditingValue(
                                text: getBloc.project!.winner?.name ?? ''),
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              return getBloc.suppliers
                                  .where(
                                    (SupplierEntity entity) =>
                                (entity.name
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
                                      initialValue: getBloc.project!.items ??
                                          [],
                                      initialChildSize: 0.4,
                                      listType: MultiSelectListType.LIST,
                                      searchable: true,
                                      buttonText: const Text("Selected Items"),
                                      title: const Text("Items"),
                                      onSelectionChanged: (values) {
                                        setState(() {
                                          getBloc.project!.items =
                                              values.cast<ItemEntity>();
                                        });
                                      },
                                      // '${e.type}: ${e.name} - ${e.manufacturer} - ${e.hsCode}\n${e.description}\n'
                                      items: getBloc.items
                                          .map((e) =>
                                          MultiSelectItem(
                                              e,
                                              Text.rich(
                                                TextSpan(
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text:
                                                        '${e.type}: ${e
                                                            .name}\n',
                                                        style: primaryTextStyle),
                                                    TextSpan(
                                                        text: e.description,
                                                        style: captionTextStyle),
                                                    TextSpan(
                                                        text: (e.manufacturer !=
                                                            null)
                                                            ? '\nManufacturer: ${e
                                                            .manufacturer}'
                                                            : '\n',
                                                        style: captionTextStyle),
                                                    TextSpan(
                                                        text: (e.hsCode != null)
                                                            ? 'HS-Code: ${e
                                                            .hsCode}'
                                                            : '',
                                                        style: captionTextStyle),
                                                  ],
                                                ),
                                              )))
                                          .toList(),
                                      onConfirm: (values) {
                                        setState(() {
                                          getBloc.project!.items =
                                              values.cast<ItemEntity>();
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
                                    getBloc.project!.items == null ||
                                        getBloc.project!.items!.isEmpty
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
                        StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Column(children: [
                            InkWell(
                                child: Text(isAdvanceOptionsShowing
                                    ? '...hide advanced options'
                                    : 'show advanced options...'),
                                onTap: () =>
                                    setState(() {
                                      isAdvanceOptionsShowing =
                                      !isAdvanceOptionsShowing;
                                    })),
                            if (isAdvanceOptionsShowing)
                              TextField(
                                controller: introController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Intro',
                                ),
                                minLines: 2,
                                maxLines: 3,
                              ),
                            if (isAdvanceOptionsShowing)
                              const SizedBox(height: 25),
                            if (isAdvanceOptionsShowing)
                              ...necessaryItems
                                  .map((e) =>
                                  CheckboxListTile(
                                      title: Text(e.title),
                                      value: e.isAvailable,
                                      onChanged: (newValue) {
                                        setState(() {
                                          e.isAvailable = newValue ?? false;
                                        });
                                      }))
                                  .toList(),
                            if (isAdvanceOptionsShowing &&
                                necessaryItems[4].isAvailable)
                              TextField(
                                controller: termsOfDeliveryExtraDataController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText:
                                  '${necessaryItems[4].title} extra data',
                                ),
                              ),
                            if (isAdvanceOptionsShowing &&
                                necessaryItems[4].isAvailable)
                              const SizedBox(height: 25),
                            if (isAdvanceOptionsShowing &&
                                necessaryItems[5].isAvailable)
                              TextField(
                                controller: packingExtraDataController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText:
                                  '${necessaryItems[5].title} extra data',
                                ),
                              ),
                            if (isAdvanceOptionsShowing &&
                                necessaryItems[5].isAvailable)
                              const SizedBox(height: 25),
                            if (isAdvanceOptionsShowing &&
                                necessaryItems[7].isAvailable)
                              TextField(
                                controller: termsOfPaymentExtraDataController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText:
                                  '${necessaryItems[7].title} extra data',
                                ),
                              ),
                            if (isAdvanceOptionsShowing &&
                                necessaryItems[7].isAvailable)
                              const SizedBox(height: 25),
                            if (isAdvanceOptionsShowing)
                              TextField(
                                controller: outroController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Outro',
                                ),
                                minLines: 2,
                                maxLines: 3,
                              ),
                            if (isAdvanceOptionsShowing)
                              const SizedBox(height: 25),
                          ]);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: ElevatedButton(
                    onPressed: () {
                      getBloc.project!.name = nameController.text;

                      necessaryItems[4].extraData =
                          termsOfDeliveryExtraDataController.text;
                      necessaryItems[5].extraData =
                          packingExtraDataController.text;
                      necessaryItems[7].extraData =
                          termsOfPaymentExtraDataController.text;

                      callEvent(ProjectAddEventAddingDone());

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            PDFScreen(
                              intro: introController.text,
                              outro: outroController.text,
                              project: getBloc.project!,
                              user: getBloc.user,
                              company: getBloc.company,
                              necessaryInformation: necessaryItems
                                  .where((element) => element.isAvailable)
                                  .map((e) =>
                              '${e.title}${(e.extraData?.isNotEmpty == true)
                                  ? ' (${e.extraData})'
                                  : ''}')
                                  .toList(),
                            ),
                      )).then((value) {
                        getBloc.project = null;
                        Navigator.of(context).pop();
                      });
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

class NecessaryItem {
  String title;
  String? extraData;
  bool isAvailable;

  NecessaryItem({
    required this.title,
    this.extraData,
    required this.isAvailable,
  });
}
