import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/enquiry_entity.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/presenter/common/enquiry_name_formatter.dart';
import 'package:kexcel/presenter/utils/pdf_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart' show getDownloadsDirectory;

class PDFScreen extends StatelessWidget {
  final String intro;
  final String outro;
  final EnquiryEntity enquiry;
  final UserEntity user;
  final CompanyEntity company;
  final List<String> necessaryInformation;

  const PDFScreen({
    required this.intro,
    required this.outro,
    required this.enquiry,
    required this.user,
    required this.company,
    this.necessaryInformation = const [],
    super.key,
  });

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

    final appDocDir = await getDownloadsDirectory();
    final appDocPath = appDocDir?.path;
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

    int index = 1;
    final invoice = Invoice(
      intro: intro,
      outro: outro,
      code: getEnquiryName(company: company, enquiry: enquiry),
      items: enquiry.items
          .map((e) => ItemEntityWithExtraData(
              sortIndex: index++,
              item: e.item,
              quantity: e.quantity,
              dimension: e.dimension))
          .toList(),
      necessaryInformation: necessaryInformation,
      user: user,
      company: company,
      baseColor: PdfColors.grey800,
      accentColor: PdfColors.indigo800,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF'),
      ),
      body: PdfPreview(
        build: (format) => generateInvoice(invoice, format),
        actions: actions,
        onPrinted: _showPrintedToast,
        onShared: _showSharedToast,
      ),
    );
  }
}
