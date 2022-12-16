import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/feature/information/base_information_screen.dart';
import 'package:kexcel/presenter/feature/information/item/item_bloc.dart';
import 'package:kexcel/presenter/feature/information/item/item_bloc_event.dart';
import 'package:kexcel/presenter/utils/excel_utils.dart';
import 'package:kexcel/presenter/utils/text_styles.dart';
import 'package:kexcel/presenter/widget/app_modal_bottom_sheet.dart';

class ItemScreen extends BaseInformationScreen<ItemBloc, ItemEntity> {
  const ItemScreen({super.key});

  @override
  String get title => 'itemsManagement'.translate;

  @override
  BaseBlocEvent get initEvent => ItemEventInit();

  @override
  BaseBlocEvent deleteEvent(ItemEntity entity) => ItemEventDelete(entity);

  @override
  Widget itemDetails(ItemEntity entity) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${entity.id} ${entity.name}',
          softWrap: true,
          maxLines: 2,
          style: primaryTextStyle.large,
        ),
        const SizedBox(height: 10),
        FittedBox(
          child: Text(
            '${'type'.translate}: ${entity.type ?? ''}',
            style: primaryTextStyle.medium,
          ),
        ),
        const SizedBox(height: 10),
        FittedBox(
          child: Text(
            '${'manufacturer'.translate}: ${entity.manufacturer?.name ?? ''}',
            style: captionTextStyle.medium,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${'description'.translate}: ${entity.description ?? ''}',
          softWrap: true,
          maxLines: 2,
          style: captionTextStyle.medium,
        ),
        const SizedBox(height: 10),
        FittedBox(
          child: Text(
            '${'hsCode'.translate}: ${entity.hsCode ?? ''}',
            style: captionTextStyle.medium,
          ),
        ),
      ],
    );
  }

  @override
  void editItemDetails(BuildContext context, {ItemEntity? entity}) {
    final TextEditingController nameController =
    TextEditingController(text: entity?.name ?? '');
    final TextEditingController descriptionController =
    TextEditingController(text: entity?.description ?? '');
    final TextEditingController typeController =
    TextEditingController(text: entity?.type ?? '');
    final TextEditingController hsCodeController =
    TextEditingController(text: entity?.hsCode ?? '');
    SupplierEntity? manufacturer = entity?.manufacturer;

    showAppBottomSheet(
      isDismissible: false,
      enableDrag: false,
      showCloseIcon: true,
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'name'.translate,
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: typeController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'type'.translate,
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
              onSelected: (SupplierEntity entity) => manufacturer = entity,
              displayStringForOption: (SupplierEntity entity) =>
              entity.name,
              initialValue: TextEditingValue(text: manufacturer?.name ?? ''),
              optionsBuilder: (TextEditingValue textEditingValue) {
                return getBloc.manufacturers
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
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'description'.translate,
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: hsCodeController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'hsCode'.translate,
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              final newEntity = ItemEntity(
                id: entity?.id ?? -1,
                name: nameController.text,
                manufacturer: manufacturer,
                description: descriptionController.text,
                hsCode: hsCodeController.text,
              );
              if (entity == null) {
                callEvent(ItemEventAddingDone(newEntity));
              } else {
                callEvent(ItemEventEditingDone(newEntity));
              }
              Navigator.pop(context);
            },
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: Center(child: Text('save'.translate)),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  @override
  void import() async {
    final importedData = await importFromFile();

    List<ItemEntity> items = [];

    if (importedData != null && importedData.length > 1) {
      for (int i = 0; i < importedData.length; i++) {
        if (i == 0 || importedData[i] == null) {} else {
          final item = importedData[i];
          if (item?[1] == null || item?[1]?.isEmpty == true) {
            break;
          }
          items.add(ItemEntity(
            id: 0,
            name: item?[0] ?? '',
            type: item?[1] ?? '',
            manufacturer: findSupplier(item?[2]),
            description: item?[3],
            hsCode: item?[4],
          ));
        }
      }
    }
    callEvent(ItemEventImport(items));
  }

  @override
  void export() {
    exportListToFile(
      [
        'id'.translate,
        'name'.translate,
        'type'.translate,
        'manufacturer'.translate,
        'description'.translate,
        'hsCode'.translate,
      ],
      getBloc.items
          .map(
            (e) =>
        [
          e.id.toString(),
          e.name,
          e.type,
          e.manufacturer?.name,
          e.description,
          e.hsCode,
        ],
      )
          .toList(),
      'export_items.xlsx',
    );
  }

  SupplierEntity? findSupplier(String? manufactureName) {
    if (manufactureName?.isNotEmpty == true) {
      for (var element in getBloc.manufacturers) {
        if ((element.symbol?.contains(manufactureName!) ?? false) ||
            element.name.contains(manufactureName!)) {
          return element;
        }
      }
      callEvent(ItemEventAddManufacturer(manufactureName!));
      return SupplierEntity(id: 0, code: 'M000', name: manufactureName);
    }
    return null;
  }
}
