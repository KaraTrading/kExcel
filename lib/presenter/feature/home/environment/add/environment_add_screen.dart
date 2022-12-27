import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/entity/environment_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/feature/home/pdf/pdf_screen.dart';
import 'package:kexcel/presenter/utils/app_colors.dart';
import 'package:kexcel/presenter/utils/text_styles.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'environment_add_bloc.dart';
import 'environment_add_bloc_event.dart';

class EnvironmentAddScreen extends BaseScreen<EnvironmentAddBloc> {
  final EnvironmentEntity? entity;

  const EnvironmentAddScreen({this.entity, super.key});

  @override
  AppBar? get appBar => AppBar(title: Text('environmentAdd'.translate));

  @override
  FloatingActionButton? floatingActionButton(BuildContext context) => null;

  @override
  Widget screenBody(BuildContext context) {
    callEvent(EnvironmentAddEventInit());

    if (getBloc.environment == null) {
      if (entity != null) {
        getBloc.environment = entity!;
      } else {
        getBloc.environment = EnvironmentEntity(projectId: 0, id: 0, name: '');
      }
    }

    final TextEditingController nameController =
        TextEditingController(text: getBloc.environment?.name);

    bool isAdvanceOptionsShowing = false;

    final TextEditingController introController = TextEditingController(
      text: 'environmentIntro'.translate,
    );

    final TextEditingController outroController = TextEditingController(
      text: 'environmentOutro'.translate,
    );

    final necessaryItems = [
      NecessaryItem(title: 'ourReference'.translate, isAvailable: true),
      NecessaryItem(title: 'scopeOfSupply'.translate, isAvailable: true),
      NecessaryItem(title: 'prices'.translate, isAvailable: true),
      NecessaryItem(title: 'timeOfDelivery'.translate, isAvailable: true),
      NecessaryItem(title: 'termsOfDelivery'.translate, isAvailable: true),
      NecessaryItem(title: 'packing'.translate, isAvailable: true),
      NecessaryItem(title: 'weights'.translate, isAvailable: true),
      NecessaryItem(title: 'termsOfPayment'.translate, isAvailable: true),
      NecessaryItem(title: 'countryOfOrigin'.translate, isAvailable: true),
      NecessaryItem(title: 'customsTariff'.translate, isAvailable: true),
      NecessaryItem(title: 'validityOfOffer'.translate, isAvailable: true),
    ];

    final TextEditingController termsOfDeliveryExtraDataController =
        TextEditingController(text: necessaryItems[4].extraData);
    final TextEditingController packingExtraDataController =
        TextEditingController(text: necessaryItems[5].extraData);
    final TextEditingController termsOfPaymentExtraDataController =
        TextEditingController(text: necessaryItems[7].extraData);

    void updateProject() {
      callEvent(EnvironmentAddEventUpdatedProject());
      Future.delayed(const Duration(milliseconds: 50), () {
        nameController.text = getBloc.environment!.name;
      });
    }

    return DataLoadBlocBuilder<EnvironmentAddBloc, List<ItemEntity>?>(
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
                              getBloc.environment!.client = entity;
                              updateProject();
                            },
                            displayStringForOption: (ClientEntity entity) =>
                                entity.name,
                            initialValue: TextEditingValue(
                                text: getBloc.environment!.client?.name ?? ''),
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
                            labelText: 'supplier'.translate,
                          ),
                          child: Autocomplete(
                            onSelected: (SupplierEntity entity) {
                              getBloc.environment!.supplier = entity;
                              updateProject();
                            },
                            displayStringForOption: (SupplierEntity entity) =>
                                entity.name,
                            initialValue: TextEditingValue(
                                text:
                                    getBloc.environment!.supplier?.name ?? ''),
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
                                  initialValue:
                                      getBloc.environment!.items ?? [],
                                  initialChildSize: 0.4,
                                  listType: MultiSelectListType.LIST,
                                  searchable: true,
                                  buttonText: Text('selectedItems'.translate),
                                  title: Text('items'.translate),
                                  onSelectionChanged: (values) {
                                    setState(() {
                                      getBloc.environment!.items =
                                          values.cast<ItemEntity>();
                                    });
                                  },
                                  // '${e.type}: ${e.name} - ${e.manufacturer} - ${e.hsCode}\n${e.description}\n'
                                  items: getBloc.items
                                      .map((e) => MultiSelectItem(
                                          e,
                                          Text.rich(
                                            TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        '${e.type}: ${e.name}\n',
                                                    style: primaryTextStyle),
                                                TextSpan(
                                                    text: e.description,
                                                    style: captionTextStyle),
                                                TextSpan(
                                                    text: (e.manufacturer !=
                                                            null)
                                                        ? '\n${'manufacturer'.translate}: ${e.manufacturer}'
                                                        : '\n',
                                                    style: captionTextStyle),
                                                TextSpan(
                                                    text: (e.hsCode != null)
                                                        ? '${'hsCode'.translate}: ${e.hsCode}'
                                                        : '',
                                                    style: captionTextStyle),
                                              ],
                                            ),
                                          )))
                                      .toList(),
                                  onConfirm: (values) {
                                    setState(() {
                                      getBloc.environment!.items =
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
                                getBloc.environment!.items == null ||
                                        getBloc.environment!.items!.isEmpty
                                    ? Container(
                                        padding: const EdgeInsets.all(10),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'noneSelected'.translate,
                                          style: const TextStyle(
                                            color: Colors.black54,
                                          ),
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
                                    ? 'hideMore'.translate
                                    : 'showMore'.translate),
                                onTap: () => setState(() {
                                      isAdvanceOptionsShowing =
                                          !isAdvanceOptionsShowing;
                                    })),
                            if (isAdvanceOptionsShowing)
                              TextField(
                                controller: introController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'intro'.translate,
                                ),
                                minLines: 2,
                                maxLines: 3,
                              ),
                            if (isAdvanceOptionsShowing)
                              const SizedBox(height: 25),
                            if (isAdvanceOptionsShowing)
                              ...necessaryItems
                                  .map((e) => CheckboxListTile(
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
                                      '${necessaryItems[5].title} ${'extraData'.translate}',
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
                                      '${necessaryItems[7].title} ${'extraData'.translate}',
                                ),
                              ),
                            if (isAdvanceOptionsShowing &&
                                necessaryItems[7].isAvailable)
                              const SizedBox(height: 25),
                            if (isAdvanceOptionsShowing)
                              TextField(
                                controller: outroController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'outro'.translate,
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
                      getBloc.environment!.name = nameController.text;

                      necessaryItems[4].extraData =
                          termsOfDeliveryExtraDataController.text;
                      necessaryItems[5].extraData =
                          packingExtraDataController.text;
                      necessaryItems[7].extraData =
                          termsOfPaymentExtraDataController.text;

                      callEvent(EnvironmentAddEventAddingDone());

                      Navigator.of(context)
                          .push(MaterialPageRoute(
                        builder: (context) => PDFScreen(
                          intro: introController.text,
                          outro: outroController.text,
                          project: getBloc.environment!,
                          user: getBloc.user,
                          company: getBloc.company,
                          necessaryInformation: necessaryItems
                              .where((element) => element.isAvailable)
                              .map((e) =>
                                  '${e.title}${(e.extraData?.isNotEmpty == true) ? ' (${e.extraData})' : ''}')
                              .toList(),
                        ),
                      ))
                          .then((value) {
                        getBloc.environment = null;
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
