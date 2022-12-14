/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/entity/supplier_entity.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<Uint8List> generateInvoice(PdfPageFormat pageFormat) async {
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
    customerName: 'Wyan Aleko',
    customerAddress: '54 rue de Rivoli\n75001 Paris, France',
    contactInfo: 'Wyan Aleko\nManagement Assistant\nAleko@metpool.de',
    baseColor: PdfColors.grey800,
    accentColor: PdfColors.indigo800,
  );

  return await invoice.buildPdf(pageFormat);
}

class Invoice {
  final List<ItemEntityWithExtraData> items;
  final List<String> necessaryInformation;
  final String customerName;
  final String customerAddress;
  final String invoiceNumber;
  final String contactInfo;
  final PdfColor baseColor;
  final PdfColor accentColor;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor => baseColor.isLight ? _darkColor : _lightColor;

  PdfColor get _accentTextColor => baseColor.isLight ? _lightColor : _darkColor;

  ByteData? _logo;

  // String? _bgShape;

  pw.Font? _fontTitle;
  pw.Font? _fontLight;
  pw.Font? _fontBold;

  Invoice({
    required this.items,
    this.necessaryInformation = const [],
    required this.customerName,
    required this.customerAddress,
    required this.invoiceNumber,
    required this.contactInfo,
    required this.baseColor,
    required this.accentColor,
  });

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    // Create a PDF document.
    final doc = pw.Document();
    _fontTitle = await PdfGoogleFonts.cairoExtraLight();
    _fontLight = await PdfGoogleFonts.firaSansExtraLight();
    _fontBold = await PdfGoogleFonts.firaSansExtraLight();
    // _logo = await rootBundle.loadString('assets/images/logo.png');
    _logo = await rootBundle.load('assets/images/logo.png');
    // _bgShape = await rootBundle.loadString('assets/vectors/invoice.svg');

    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        header: _buildHeader,
        footer: _buildFooter,
        pageTheme: _buildTheme(_fontLight!, _fontBold!),
        build: (context) => [
          _contentHeader(context),
          _contentTable(context),
          pw.SizedBox(height: 20),
          _contentFooter(context),
          pw.SizedBox(height: 20),
          _termsAndConditions(context),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.PageTheme _buildTheme(
    // PdfPageFormat pageFormat,
    pw.Font base,
    pw.Font bold,
  ) {
    return pw.PageTheme(
      margin:
          const pw.EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 30),
      // pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
      ),
      // buildBackground: (context) => pw.FullPage(
      //   ignoreMargins: true,
      //   child: pw.SvgImage(svg: _bgShape!),
      // ),
    );
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              width: 120,
              child: pw.Text(
                'Enquiry NO.: $invoiceNumber',
                style: pw.TextStyle(
                  color: _baseTextColor,
                  font: _fontTitle,
                  fontSize: 10,
                ),
              ),
            ),
            pw.Column(
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.only(left: 20, right: 20),
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Row(
                    children: [
                      pw.Text(
                        'METPOOL',
                        style: pw.TextStyle(
                          color: accentColor,
                          font: _fontTitle,
                          fontSize: 25,
                        ),
                      ),
                      pw.SizedBox(width: 8),
                      pw.Text(
                        'GmbH',
                        style: pw.TextStyle(
                          color: accentColor,
                          font: _fontTitle,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.only(top: 10),
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    'Am Seestern 8, 40547 Dusseldorf, Germany',
                    style: pw.TextStyle(
                      color: baseColor,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            pw.Container(
              width: 120,
              alignment: pw.Alignment.topRight,
              height: 60,
              child: pw.Image(pw.MemoryImage(_logo!.buffer.asUint8List()), width: 60, height: 60),
            ),
          ],
        ),
        pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 8),
            height: 1,
            color: baseColor),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          margin: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Our Contact:',
                style: pw.TextStyle(
                  color: baseColor,
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.only(top: 5, left: 5),
                child: pw.Text(
                  contactInfo,
                  style: const pw.TextStyle(
                    fontSize: 8,
                    lineSpacing: 3,
                    color: _darkColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        pw.Container(
          margin: const pw.EdgeInsets.only(top: 5, bottom: 10),
          child: pw.Text(
            'Dear Sir/Madame,\nKindly provide us with your best offer for delivering the list items:',
            style: const pw.TextStyle(
              fontSize: 8,
              lineSpacing: 5,
              color: _darkColor,
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      '#',
      'Item Description',
      'Dimension',
      'Qty',
    ];

    return pw.Table.fromTextArray(
      border: null,
      columnWidths: {
        0: const pw.IntrinsicColumnWidth(flex: 0.75),
        1: const pw.IntrinsicColumnWidth(flex: 11),
        2: const pw.IntrinsicColumnWidth(flex: 5),
        3: const pw.IntrinsicColumnWidth(flex: 1),
      },
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellPadding:
          const pw.EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5),
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
      },
      headerStyle: pw.TextStyle(
        color: _accentTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: accentColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        items.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => items[row].getIndex(col),
        ),
      ),
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Row(
      mainAxisSize: pw.MainAxisSize.max,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (necessaryInformation.isNotEmpty)
                pw.Container(
                  padding: const pw.EdgeInsets.only(bottom: 4),
                  child: pw.Text(
                    'Please be reminded, that is necessary us to have the following information included in your Quotation:',
                    style: pw.TextStyle(
                      fontSize: 8,
                      color: baseColor,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                ),
              if (necessaryInformation.isNotEmpty)
                pw.Container(
                  padding: const pw.EdgeInsets.only(bottom: 4),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      ...necessaryInformation.map(
                        (e) => pw.Container(
                          padding: const pw.EdgeInsets.only(bottom: 4),
                          child: pw.Bullet(
                              text: e,
                              bulletSize: 4,
                              bulletMargin: const pw.EdgeInsets.only(
                                  top: 1 * PdfPageFormat.mm,
                                  left: 5 * PdfPageFormat.mm,
                                  right: 5 * PdfPageFormat.mm),
                              style: const pw.TextStyle(
                                fontSize: 8,
                                lineSpacing: 2,
                                color: _darkColor,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Text(
                  'The offer is requested in English language. In case of any questions please feel free to contact me at any time.\nBest Regards,',
                  style: pw.TextStyle(
                    fontSize: 8,
                    color: baseColor,
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 4, top: 60, left: 20),
                child: pw.Text(
                  'Abdalla Sarsour\nExecutive Director',
                  style: pw.TextStyle(
                    fontSize: 8,
                    color: baseColor,
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _termsAndConditions(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: pw.SizedBox(),
        ),
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Column(children: [
          pw.Container(
            height: 20,
            width: 100,
            child: pw.BarcodeWidget(
              barcode: pw.Barcode.pdf417(),
              data: 'Invoice# $invoiceNumber',
              drawText: false,
            ),
          ),
          pw.Container(
            child: pw.Text(
              'Page ${context.pageNumber}/${context.pagesCount}',
              style: const pw.TextStyle(
                fontSize: 12,
                color: PdfColors.black,
              ),
            ),
          )
        ])
      ],
    );
  }
}

class ItemEntityWithExtraData {
  final ItemEntity item;
  final int quantity;
  final int sortIndex;
  final String? dimension;

  ItemEntityWithExtraData({
    required this.sortIndex,
    required this.item,
    required this.quantity,
    this.dimension,
  });

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sortIndex.toString();
      case 1:
        return '${item.name}\n${item.description}';
      case 2:
        return dimension ?? '';
      case 3:
        return quantity.toString();
    }
    return '';
  }
}