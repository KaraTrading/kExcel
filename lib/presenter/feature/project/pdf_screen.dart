import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/presenter/utils/pdf_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

class PDFScreen extends StatelessWidget {
  final String intro;
  final String outro;
  final ProjectEntity project;
  final UserEntity user;
  final CompanyEntity company;
  final List<String> necessaryInformation;

  const PDFScreen({
    required this.intro,
    required this.outro,
    required this.project,
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

    int index = 1;
    final invoice = Invoice(
      intro: intro,
      outro: outro,
      invoiceNumber: project.name,
      items: project.items?.map((e) =>
              ItemEntityWithExtraData(sortIndex: index++, item: e, quantity: 1))
          .toList() ?? [],
      necessaryInformation: necessaryInformation,
      user: user,
      company: company,
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
