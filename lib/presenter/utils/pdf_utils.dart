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
import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/domain/entity/user_entity.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<Uint8List> generateEnquiry(
    EnquiryData enquiry, PdfPageFormat pageFormat) async {
  return await enquiry.buildPdf(pageFormat);
}

class EnquiryData {
  final List<ItemEntityWithExtraData> items;
  final List<String> necessaryInformation;
  final DateTime date;
  final UserEntity user;
  final CompanyEntity company;
  final String code;
  final String intro;
  final String outro;
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

  EnquiryData({
    required this.items,
    this.necessaryInformation = const [],
    required this.date,
    required this.user,
    required this.company,
    required this.code,
    required this.baseColor,
    required this.accentColor,
    required this.intro,
    required this.outro,
  });

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    // Create a PDF document.
    final doc = pw.Document();
    _fontTitle = await PdfGoogleFonts.cairoExtraLight();
    _fontLight = await PdfGoogleFonts.firaSansExtraLight();
    _fontBold = await PdfGoogleFonts.firaSansExtraLight();
    _logo = await rootBundle.load(company.logoAssetsAddress);

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
        pw.Flex(
          direction: pw.Axis.horizontal,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Flexible(
              flex: 1,
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.max,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.FittedBox(
                    child: pw.Text(
                      'Enquiry NO.: $code',
                      softWrap: true,
                      style: pw.TextStyle(
                        color: _baseTextColor,
                        font: _fontTitle,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    '${date.day.toString().padLeft(2, '0')}'
                    '.${date.month.toString().padLeft(2, '0')}'
                    '.${date.year}',
                    softWrap: false,
                    style: pw.TextStyle(
                      color: _baseTextColor,
                      font: _fontTitle,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            pw.Flexible(
              flex: 3,
              child: pw.FittedBox(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.RichText(
                        text: pw.TextSpan(children: [
                      pw.TextSpan(
                        text: company.name,
                        style: pw.TextStyle(
                          color: accentColor,
                          font: _fontTitle,
                          fontSize: 25,
                        ),
                      ),
                      if (company.nameExtension?.isNotEmpty == true)
                        const pw.TextSpan(text: ' '),
                      if (company.nameExtension?.isNotEmpty == true)
                        pw.TextSpan(
                          text: company.nameExtension,
                          style: pw.TextStyle(
                            color: PdfColors.grey,
                            font: _fontTitle,
                            fontSize: 25,
                          ),
                        ),
                    ])),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(top: 4),
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        company.address,
                        style: pw.TextStyle(
                          color: baseColor,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pw.Flexible(
              flex: 1,
              child: pw.Column(
                children: [
                  pw.Image(
                    pw.MemoryImage(_logo!.buffer.asUint8List()),
                    width: 60,
                    height: 60,
                  ),
                  pw.Container(width: double.infinity)
                ],
              ),
            ),
          ],
        ),
        pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 8, top: 8),
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
          margin: const pw.EdgeInsets.only(
            bottom: 15
          ),
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
                  '${user.name}\n${user.title}\n${user.email}${user.mobile?.isNotEmpty ?? false ? '\n${user.mobile}' : ''}',
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
            intro,
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
        1: const pw.IntrinsicColumnWidth(flex: 9),
        2: const pw.IntrinsicColumnWidth(flex: 7),
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
        2: pw.Alignment.centerLeft,
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
            color: baseColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<pw.RichText>>.generate(
        items.length,
        (row) => List<pw.RichText>.generate(
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
                    'necessaryInformationTitle'.translate,
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
                          padding: const pw.EdgeInsets.only(bottom: 2),
                          child: pw.Bullet(
                              text: e,
                              bulletSize: 4,
                              bulletMargin: const pw.EdgeInsets.only(
                                top: 1 * PdfPageFormat.mm,
                                left: 5 * PdfPageFormat.mm,
                                right: 5 * PdfPageFormat.mm,
                              ),
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
                padding: const pw.EdgeInsets.only(bottom: 3),
                child: pw.Text(
                  outro,
                  style: pw.TextStyle(
                    fontSize: 8,
                    color: baseColor,
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
              ),
              if (items.any(
                  (element) => (element.item.attachments?.isNotEmpty ?? false)))
                pw.Container(
                  padding: const pw.EdgeInsets.only(bottom: 4, top: 4),
                  child: pw.Text(
                    'findAttachments'.translate,
                    style: pw.TextStyle(
                      fontSize: 8,
                      color: baseColor,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                ),
              pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                        bottom: 4,
                        top: 40,
                        left: 20,
                      ),
                      child: pw.Text(
                        'enquirySignature'.translate,
                        style: pw.TextStyle(
                          fontSize: 8,
                          color: baseColor,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                    ),
                  ]),
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
    const footerTextStyle = pw.TextStyle(
      fontSize: 8,
      color: PdfColors.black,
    );
    return pw.Column(
      children: [
        pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 8, top: 8),
            height: 1,
            color: baseColor),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Column(children: [
              pw.Container(
                height: 20,
                width: 100,
                child: pw.BarcodeWidget(
                  barcode: pw.Barcode.pdf417(),
                  data: 'Invoice# $code',
                  drawText: false,
                ),
              ),
              pw.Container(
                child: pw.Text(
                  'Page ${context.pageNumber}/${context.pagesCount}',
                  style: footerTextStyle,
                ),
              )
            ]),
            pw.Column(children: [
              pw.Text(
                '${'ceo'.translate}: ${company.ceoName}',
                style: footerTextStyle,
              ),
              pw.Text(
                '${'tel'.translate}: ${company.telephone}',
                style: footerTextStyle,
              ),
              pw.Text(
                '${'email'.translate}: ${company.email}',
                style: footerTextStyle,
              ),
            ]),
            pw.Column(children: [
              pw.Text(
                '${'handelsRegister'.translate}: ${company.registerNumber}',
                style: footerTextStyle,
              ),
              pw.Text(
                '${'steuer'.translate}: ${company.taxNumber}',
                style: footerTextStyle,
              ),
              pw.Text(
                '${'ustId'.translate}: ${company.ustIdNumber}',
                style: footerTextStyle,
              ),
            ]),
            pw.Column(children: [
              pw.Text(
                '${'bank'.translate}: ${company.bankName}',
                style: footerTextStyle,
              ),
              pw.Text(
                '${'iban'.translate}: ${company.bankIban}',
                style: footerTextStyle,
              ),
              pw.Text(
                '${'bic'.translate}: ${company.bankBic}',
                style: footerTextStyle,
              ),
            ]),
          ],
        ),
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

  pw.RichText getIndex(int index) {
    switch (index) {
      case 0:
        return pw.RichText(text: pw.TextSpan(text: sortIndex.toString()));
      case 1:
        return pw.RichText(
          text: pw.TextSpan(
            children: [
              pw.TextSpan(
                text:
                    '${item.name}${item.attachments?.isNotEmpty ?? false ? ' **' : ''}\n',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                  font: pw.Font.helvetica(),
                ),
              ),
              pw.TextSpan(
                text:
                    '${item.manufacturer != null ? '${item.manufacturer!.name}: ' : ''}${item.type}\n',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                  font: pw.Font.helvetica(),
                ),
              ),
              if (item.description?.isNotEmpty ?? false)
                pw.TextSpan(
                  text: '.\n${item.description}',
                  style: pw.TextStyle(
                    fontSize: 8,
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
            ],
          ),
        );
      case 2:
        return pw.RichText(text: pw.TextSpan(text: dimension ?? ''));
      case 3:
        return pw.RichText(text: pw.TextSpan(text: quantity.toString()));
    }
    return pw.RichText(text: const pw.TextSpan(text: ''));
  }
}
