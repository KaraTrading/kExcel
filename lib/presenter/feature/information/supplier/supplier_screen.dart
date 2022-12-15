import 'package:flutter/material.dart';
import 'package:kexcel/core/exception/base_exception.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/feature/information/base_information_screen.dart';
import 'package:kexcel/presenter/utils/excel_utils.dart';
import 'package:kexcel/presenter/utils/text_styles.dart';
import 'package:kexcel/presenter/widget/app_modal_bottom_sheet.dart';
import 'supplier_bloc.dart';
import 'supplier_bloc_event.dart';

class SupplierScreen
    extends BaseInformationScreen<SupplierBloc, SupplierEntity> {
  const SupplierScreen({super.key});

  @override
  String get title => 'suppliersManagement'.translate;

  @override
  BaseBlocEvent deleteEvent(SupplierEntity entity) =>
      SupplierEventDelete(entity);

  @override
  BaseBlocEvent get initEvent => SupplierEventInit();

  @override
  Widget itemDetails(SupplierEntity entity) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${entity.code} ${entity.name}',
          softWrap: true,
          maxLines: 2,
          style: primaryTextStyle.large,
        ),
        const SizedBox(height: 10),
        Text(
          '${'address'.translate}: ${entity.address}',
          softWrap: true,
          maxLines: 2,
          style: primaryTextStyle.medium,
        ),
        const SizedBox(height: 10),
        FittedBox(
          child: Text(
            '${'symbol'.translate}: ${entity.symbol}',
            style: captionTextStyle.medium,
          ),
        ),
        const SizedBox(height: 10),
        FittedBox(
          child: Text(
            '${'vatId'.translate}: ${entity.vatId ?? ''}',
            style: captionTextStyle.medium,
          ),
        ),
      ],
    );
  }

  @override
  void editItemDetails(BuildContext context, {SupplierEntity? entity}) {
    String newCode = 'S000';
    if (getBloc.suppliers.isNotEmpty) {
      try {
        newCode =
            'S${((int.tryParse((getBloc.suppliers.last.code).substring(1)) ?? -1) + 1).toString().padLeft(3, "0")}';
      } on BaseException {
        newCode = '';
      }
    }

    bool isManufacturer = entity?.isManufacturer ?? false;
    final TextEditingController codeController =
        TextEditingController(text: entity?.code ?? newCode);
    final TextEditingController nameController =
        TextEditingController(text: entity?.name ?? '');
    final TextEditingController addressController =
        TextEditingController(text: entity?.address ?? '');
    final TextEditingController vatIdController =
        TextEditingController(text: entity?.vatId ?? '');
    final TextEditingController symbolController =
        TextEditingController(text: entity?.symbol ?? '');

    showAppBottomSheet(
      isDismissible: false,
      enableDrag: false,
      showCloseIcon: true,
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: codeController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'code'.translate,
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'name'.translate,
            ),
          ),
          const SizedBox(height: 25),
          StatefulBuilder(
            builder: (
              BuildContext context,
              StateSetter setState,
            ) =>
                CheckboxListTile(
              value: isManufacturer,
              onChanged: (checked) {
                setState(() {
                  isManufacturer = (checked ?? false);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              title: Text('isManufacturer'.translate),
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: addressController,
            minLines: 2,
            maxLines: 4,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'address'.translate,
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: symbolController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'symbol'.translate,
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: vatIdController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'vatId'.translate,
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              final newEntity = SupplierEntity(
                id: entity?.id ?? -1,
                name: nameController.text,
                code: codeController.text,
                vatId: vatIdController.text,
                address: addressController.text,
                symbol: symbolController.text,
                isManufacturer: isManufacturer,
              );
              if (entity == null) {
                callEvent(SupplierEventAddingDone(newEntity));
              } else {
                callEvent(SupplierEventEditingDone(newEntity));
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

    List<SupplierEntity> entities = [];

    if (importedData != null && importedData.length > 1) {
      for (int i = 0; i < importedData.length; i++) {
        if (i == 0 || importedData[i] == null) {
        } else {
          final item = importedData[i];
          if (item?[1] == null || item?[1]?.isEmpty == true) {
            break;
          }
          entities.add(SupplierEntity(
            id: 0,
            code: item?[0] ?? '',
            name: item?[1] ?? '',
            address: item?[2] ?? '',
            symbol: item?[3] ?? '',
            vatId: item?[4] ?? '',
          ));
        }
      }
    }
    callEvent(SupplierEventImport(entities));
  }

  @override
  void export() async {
    exportListToFile(
        [
          'code'.translate,
          'name'.translate,
          'address'.translate,
          'symbol'.translate,
          'vatId'.translate,
        ],
        getBloc.suppliers
            .map(
              (e) => [
                e.code,
                e.name,
                e.address,
                e.symbol,
                e.vatId,
              ],
            )
            .toList(),
        'export_suppliers.xlsx');
  }
}
