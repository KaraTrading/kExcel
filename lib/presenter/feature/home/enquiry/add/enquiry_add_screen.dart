import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/project_item_entity.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/entity/enquiry_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/feature/home/pdf/pdf_screen.dart';
import 'package:kexcel/presenter/widget/count_controller.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'enquiry_add_bloc.dart';
import 'enquiry_add_bloc_event.dart';

class EnquiryAddScreen extends BaseScreen<EnquiryAddBloc> {
  final EnquiryEntity entity;
  const EnquiryAddScreen({required this.entity, super.key});

  @override
  AppBar? get appBar => AppBar(title: Text('enquiryAdd'.translate));

  @override
  FloatingActionButton? floatingActionButton(BuildContext context) => null;

  @override
  Widget screenBody(BuildContext context) {
    callEvent(EnquiryAddEventInit(entity));
    return DataLoadBlocBuilder<EnquiryAddBloc, List<ProjectItemEntity>?>(
      noDataView: const NoItemWidget(),
      bloc: getBloc,
      builder: (BuildContext context, List<ProjectItemEntity>? entities) {
        bool isAdvanceOptionsShowing = false;

        final TextEditingController introController = TextEditingController(
          text: 'enquiryIntro'.translate,
        );

        final TextEditingController outroController = TextEditingController(
          text: 'enquiryOutro'.translate,
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

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 25),
                        InputDecorator(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 4,
                            ),
                            border: const OutlineInputBorder(gapPadding: 1),
                            labelText: 'supplier'.translate,
                          ),
                          child: Autocomplete(
                            onSelected: (SupplierEntity entity) {
                              getBloc.enquiry.supplier = entity;
                            },
                            displayStringForOption: (SupplierEntity entity) =>
                                entity.name,
                            initialValue: TextEditingValue(
                              text: getBloc.enquiry.supplier?.name ?? '',
                            ),
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
                        itemsSelector(),
                        const SizedBox(height: 25),
                        advancedOptions(
                          isAdvanceOptionsShowing,
                          introController,
                          necessaryItems,
                          termsOfDeliveryExtraDataController,
                          packingExtraDataController,
                          termsOfPaymentExtraDataController,
                          outroController,
                        ),
                      ],
                    ))),
            bottomSaveButtons(
              context,
              necessaryItems,
              termsOfDeliveryExtraDataController,
              packingExtraDataController,
              termsOfPaymentExtraDataController,
              introController,
              outroController,
            ),
          ],
        );
      },
    );
  }

  StatefulBuilder itemsSelector() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Theme.of(context).disabledColor,
              width: 1,
            )),
        child: Column(
          children: <Widget>[
            MultiSelectBottomSheetField<ProjectItemEntity?>(
              chipDisplay:
                  MultiSelectChipDisplay<ProjectItemEntity?>.none(disabled: true),
              initialValue: getBloc.enquiry.items,
              initialChildSize: 0.4,
              buttonIcon: const Icon(Icons.add),
              listType: MultiSelectListType.LIST,
              searchable: true,
              confirmText: Text('confirm'.translate),
              selectedColor: Theme.of(context).colorScheme.primary,
              unselectedColor: Theme.of(context).disabledColor,
              cancelText: Text('cancel'.translate),
              buttonText: Text('addNewItem'.translate),
              title: Text('items'.translate),
              onSelectionChanged: (values) {
                setState(() {
                  getBloc.enquiry.items = values
                      .cast<ProjectItemEntity>()
                      .toList();
                });
              },
              items: getBloc.enquiry.project.items
                  .map((e) => MultiSelectItem(e, multiSelectText(e.item, context)))
                  .toList(),
              onConfirm: (values) {
                setState(() {
                  getBloc.enquiry.items = values
                      .cast<ProjectItemEntity>()
                      .toList();
                });
              },
            ),
            getBloc.enquiry.items.isEmpty
                ? Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Text('noneSelected'.translate),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: getBloc.enquiry.items
                        .map((e) => enquiryItemWidget(context, e))
                        .toList(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget enquiryItemWidget(
    BuildContext context,
    ProjectItemEntity item,
  ) {
    final TextEditingController textController = TextEditingController(
      text: item.dimension,
    );
    return Card(
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.item.toString()),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return CountController(
                    decrementIconBuilder: (enabled) => Icon(
                      Icons.remove_rounded,
                      color: enabled
                          ? Theme.of(context).colorScheme.onBackground
                          : Theme.of(context).colorScheme.background,
                      size: 16,
                    ),
                    incrementIconBuilder: (enabled) => Icon(
                      Icons.add_rounded,
                      color: enabled
                          ? Theme.of(context).colorScheme.onBackground
                          : Theme.of(context).colorScheme.background,
                      size: 16,
                    ),
                    countBuilder: (count) => Text(
                      count.toString(),
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                    ),
                    count: item.quantity,
                    updateCount: (count) => setState(() {
                      item.quantity = count;
                    }),
                    stepSize: 1,
                    minimum: 1,
                  );
                })
              ],
            ),
            TextField(
              minLines: 1,
              maxLines: 20,
              controller: textController,
              onChanged: (text) => item.dimension = text,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'dimension'.translate,
              ),
            ),
          ],
        ),
      ),
    );
  }

  StatefulBuilder advancedOptions(
    bool isAdvanceOptionsShowing,
    TextEditingController introController,
    List<NecessaryItem> necessaryItems,
    TextEditingController termsOfDeliveryExtraDataController,
    TextEditingController packingExtraDataController,
    TextEditingController termsOfPaymentExtraDataController,
    TextEditingController outroController,
  ) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(children: [
        InkWell(
            child: Text(
              isAdvanceOptionsShowing
                  ? 'hideMore'.translate
                  : 'showMore'.translate,
            ),
            onTap: () => setState(() {
                  isAdvanceOptionsShowing = !isAdvanceOptionsShowing;
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
        if (isAdvanceOptionsShowing) const SizedBox(height: 25),
        if (isAdvanceOptionsShowing)
          ...necessaryItems
              .map(
                (e) => CheckboxListTile(
                    checkColor: Theme.of(context).colorScheme.onPrimary,
                    activeColor: Theme.of(context).colorScheme.primary,
                    title: Text(e.title),
                    value: e.isAvailable,
                    onChanged: (newValue) {
                      setState(() {
                        e.isAvailable = newValue ?? false;
                      });
                    }),
              )
              .toList(),
        if (isAdvanceOptionsShowing && necessaryItems[4].isAvailable)
          TextField(
            controller: termsOfDeliveryExtraDataController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: '${necessaryItems[4].title} extra data',
            ),
          ),
        if (isAdvanceOptionsShowing && necessaryItems[4].isAvailable)
          const SizedBox(height: 25),
        if (isAdvanceOptionsShowing && necessaryItems[5].isAvailable)
          TextField(
            controller: packingExtraDataController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: '${necessaryItems[5].title} ${'extraData'.translate}',
            ),
          ),
        if (isAdvanceOptionsShowing && necessaryItems[5].isAvailable)
          const SizedBox(height: 25),
        if (isAdvanceOptionsShowing && necessaryItems[7].isAvailable)
          TextField(
            controller: termsOfPaymentExtraDataController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: '${necessaryItems[7].title} ${'extraData'.translate}',
            ),
          ),
        if (isAdvanceOptionsShowing && necessaryItems[7].isAvailable)
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
        if (isAdvanceOptionsShowing) const SizedBox(height: 25),
      ]);
    });
  }

  Text multiSelectText(ItemEntity e, BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '${e.type}: ${e.name}\n',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextSpan(
            text: e.description,
            style: Theme.of(context).textTheme.caption,
          ),
          TextSpan(
            text: (e.manufacturer != null)
                ? '\n${'manufacturer'.translate}: ${e.manufacturer}'
                : '\n',
            style: Theme.of(context).textTheme.caption,
          ),
          TextSpan(
            text:
                (e.hsCode != null) ? '${'hsCode'.translate}: ${e.hsCode}' : '',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }

  Widget bottomSaveButtons(
    BuildContext context,
    List<NecessaryItem> necessaryItems,
    TextEditingController termsOfDeliveryExtraDataController,
    TextEditingController packingExtraDataController,
    TextEditingController termsOfPaymentExtraDataController,
    TextEditingController introController,
    TextEditingController outroController,
  ) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceVariant,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              saveEnquiry();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('save'.translate),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              saveEnquiry();
              showPdf(
                context: context,
                intro: introController.text,
                outro: outroController.text,
                necessaryItems: necessaryItems,
                termsOfDeliveryExtra: termsOfDeliveryExtraDataController.text,
                packingExtra: packingExtraDataController.text,
                termsOfPaymentExtra: termsOfPaymentExtraDataController.text,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('saveAndShow'.translate),
            ),
          ),
        ],
      ),
    );
  }

  void saveEnquiry() {
    callEvent(EnquiryAddEventAddingDone());
  }

  void showPdf({
    required BuildContext context,
    required String intro,
    required String outro,
    required List<NecessaryItem> necessaryItems,
    required String termsOfDeliveryExtra,
    required String packingExtra,
    required String termsOfPaymentExtra,
  }) {
    necessaryItems[4].extraData = termsOfDeliveryExtra;
    necessaryItems[5].extraData = packingExtra;
    necessaryItems[7].extraData = termsOfPaymentExtra;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PDFScreen(
          intro: intro,
          outro: outro,
          enquiry: getBloc.enquiry,
          user: getBloc.user,
          company: getBloc.company,
          necessaryInformation: necessaryItems
              .where((element) => element.isAvailable)
              .map((e) =>
                  '${e.title}${(e.extraData?.isNotEmpty == true) ? ' (${e.extraData})' : ''}')
              .toList(),
        ),
      ),
    );
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
