import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/presenter/utils/pdf_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:pdf/widgets.dart' as pw;

class PDFScreen extends StatelessWidget {
  const PDFScreen({Key? key}) : super(key: key);

  void _showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }

  Future<void> _saveAsFile(
      BuildContext context,
      LayoutCallback build,
      PdfPageFormat pageFormat,
      ) async {
    final bytes = await build(pageFormat);

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File('$appDocPath/document.pdf');
    debugPrint('Save as file ${file.path} ...');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        PdfPreviewAction(
          icon: const Icon(Icons.save),
          onPressed: _saveAsFile,
        )
    ];

    final lorem = pw.LoremText();

    final items = <ItemEntityWithExtraData>[
      ItemEntityWithExtraData(
        sortIndex: 0,
        item: ItemEntity(
            id: 0,
            name: lorem.sentence(2),
            description: lorem.sentence(15),
            hsCode: lorem.random.nextInt(8000).toString(),
            manufacturer: SupplierEntity(
                id: 0,
                code: 'S${lorem.random.nextInt(999)}',
                name: lorem.sentence(2))),
        quantity: lorem.random.nextInt(1),
      ),
      ItemEntityWithExtraData(
          sortIndex: 1,
          item: ItemEntity(
              id: 0,
              name: lorem.sentence(2),
              description: lorem.sentence(15),
              hsCode: lorem.random.nextInt(8000).toString(),
              manufacturer: SupplierEntity(
                  id: 0,
                  code: 'S${lorem.random.nextInt(999)}',
                  name: lorem.sentence(2))),
          quantity: lorem.random.nextInt(1)),
      ItemEntityWithExtraData(
          sortIndex: 2,
          item: ItemEntity(
              id: 0,
              name: lorem.sentence(2),
              description: lorem.sentence(15),
              hsCode: lorem.random.nextInt(8000).toString(),
              manufacturer: SupplierEntity(
                  id: 0,
                  code: 'S${lorem.random.nextInt(999)}',
                  name: lorem.sentence(2))),
          quantity: lorem.random.nextInt(1)),
      ItemEntityWithExtraData(
          sortIndex: 3,
          item: ItemEntity(
              id: 0,
              name: lorem.sentence(2),
              description: lorem.sentence(15),
              hsCode: lorem.random.nextInt(8000).toString(),
              manufacturer: SupplierEntity(
                  id: 0,
                  code: 'S${lorem.random.nextInt(999)}',
                  name: lorem.sentence(2))),
          quantity: lorem.random.nextInt(1)),
      ItemEntityWithExtraData(
          sortIndex: 4,
          item: ItemEntity(
              id: 0,
              name: lorem.sentence(2),
              description: lorem.sentence(15),
              hsCode: lorem.random.nextInt(8000).toString(),
              manufacturer: SupplierEntity(
                  id: 0,
                  code: 'S${lorem.random.nextInt(999)}',
                  name: lorem.sentence(2))),
          quantity: lorem.random.nextInt(1)),
      ItemEntityWithExtraData(
          sortIndex: 5,
          item: ItemEntity(
              id: 0,
              name: lorem.sentence(2),
              description: lorem.sentence(15),
              hsCode: lorem.random.nextInt(8000).toString(),
              manufacturer: SupplierEntity(
                  id: 0,
                  code: 'S${lorem.random.nextInt(999)}',
                  name: lorem.sentence(2))),
          quantity: lorem.random.nextInt(1)),
      ItemEntityWithExtraData(
          sortIndex: 6,
          item: ItemEntity(
              id: 0,
              name: lorem.sentence(2),
              description: lorem.sentence(15),
              hsCode: lorem.random.nextInt(8000).toString(),
              manufacturer: SupplierEntity(
                  id: 0,
                  code: 'S${lorem.random.nextInt(999)}',
                  name: lorem.sentence(2))),
          quantity: lorem.random.nextInt(1)),
      ItemEntityWithExtraData(
          sortIndex: 7,
          item: ItemEntity(
              id: 0,
              name: lorem.sentence(2),
              description: lorem.sentence(15),
              hsCode: lorem.random.nextInt(8000).toString(),
              manufacturer: SupplierEntity(
                  id: 0,
                  code: 'S${lorem.random.nextInt(999)}',
                  name: lorem.sentence(2))),
          quantity: lorem.random.nextInt(1)),
      ItemEntityWithExtraData(
          sortIndex: 8,
          item: ItemEntity(
              id: 0,
              name: lorem.sentence(2),
              description: lorem.sentence(15),
              hsCode: lorem.random.nextInt(8000).toString(),
              manufacturer: SupplierEntity(
                  id: 0,
                  code: 'S${lorem.random.nextInt(999)}',
                  name: lorem.sentence(2))),
          quantity: lorem.random.nextInt(1)),
      ItemEntityWithExtraData(
          sortIndex: 9,
          item: ItemEntity(
              id: 0,
              name: lorem.sentence(2),
              description: lorem.sentence(15),
              hsCode: lorem.random.nextInt(8000).toString(),
              manufacturer: SupplierEntity(
                  id: 0,
                  code: 'S${lorem.random.nextInt(999)}',
                  name: lorem.sentence(2))),
          quantity: lorem.random.nextInt(1)),
      ItemEntityWithExtraData(
          sortIndex: 10,
          item: ItemEntity(
              id: 0,
              name: lorem.sentence(2),
              description: lorem.sentence(15),
              hsCode: lorem.random.nextInt(8000).toString(),
              manufacturer: SupplierEntity(
                  id: 0,
                  code: 'S${lorem.random.nextInt(999)}',
                  name: lorem.sentence(2))),
          quantity: lorem.random.nextInt(1)),
      ItemEntityWithExtraData(
          sortIndex: 11,
          item: ItemEntity(
              id: 0,
              name: lorem.sentence(2),
              description: lorem.sentence(15),
              hsCode: lorem.random.nextInt(8000).toString(),
              manufacturer: SupplierEntity(
                  id: 0,
                  code: 'S${lorem.random.nextInt(999)}',
                  name: lorem.sentence(2))),
          quantity: lorem.random.nextInt(1)),
      ItemEntityWithExtraData(
          sortIndex: 12,
          item: ItemEntity(
              id: 0,
              name: lorem.sentence(2),
              description: lorem.sentence(15),
              hsCode: lorem.random.nextInt(8000).toString(),
              manufacturer: SupplierEntity(
                  id: 0,
                  code: 'S${lorem.random.nextInt(999)}',
                  name: lorem.sentence(2))),
          quantity: lorem.random.nextInt(1)),
      ItemEntityWithExtraData(
          sortIndex: 13,
          item: ItemEntity(
              id: 0,
              name: lorem.sentence(2),
              description: lorem.sentence(15),
              hsCode: lorem.random.nextInt(8000).toString(),
              manufacturer: SupplierEntity(
                  id: 0,
                  code: 'S${lorem.random.nextInt(999)}',
                  name: lorem.sentence(2))),
          quantity: lorem.random.nextInt(1)),
    ];

    final invoice = Invoice(
      invoiceNumber: '22PO32-AL',
      items: items,
      necessaryInformation: [
        'Our reference',
        'Scope of supply (Description of goods)',
        'Item price and total price',
        'Time of delivery',
        'Terms of delivery (Ex works)',
        'Packing (seaworthy packing)',
        'Weights: net & gross (estimated at least)',
        'Terms of payment',
        'Country of origin',
        'Customs tariff number / HS code',
        'Validity of offer',
        'Technical datasheet'
      ],
      user: UserEntity(
          name: 'Wyan Aleko',
          companyId: 1,
          title: 'Management Assistant',
          email: 'Aleko@metpool.de'),
      company: CompanyEntity(
          id: 1,
          name: 'Metpool',
          nameExtension: 'GmbH',
          address: '',
          logoAssetsAddress: '',
          ceoName: 'ceoName',
          registerNumber: 'registerNumber',
          taxNumber: 'taxNumber',
          ustIdNumber: 'ustIdNumber',
          email: 'email',
          telephone: 'telephone',
          bankName: 'bankName',
          bankIban: 'bankIban',
          bankBic: 'bankBic'),
      baseColor: PdfColors.grey800,
      accentColor: PdfColors.indigo800,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter PDF Demo'),
      ),
      body: PdfPreview(
        maxPageWidth: 700,
        build: (format) => generateInvoice(invoice, format),
        actions: actions,
        onPrinted: _showPrintedToast,
        onShared: _showSharedToast,
      ),
    );
  }
}
