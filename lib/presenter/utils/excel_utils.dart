import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xl;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

Future<void> exportListToFile<T>(
    List<String> titles, List<List<String?>> items, String fileName) async {
  final xl.Workbook workbook = xl.Workbook();
  final xl.Worksheet sheet = workbook.worksheets[0];
  for (int i = 0; i < items.length; i++) {
    final item = items[i];
    for (int j = 0; j < titles.length; j++) {
      if (i == 0) {
        sheet.getRangeByIndex(i + 1, j + 1).setText(titles[j]);
      }
      sheet.getRangeByIndex(i + 2, j + 1).setText(item[j] ?? '');
    }
  }
  final List<int> bytes = workbook.saveAsStream();
  final directory = await getApplicationDocumentsDirectory();
  final file = await File('${directory.path}/$fileName').writeAsBytes(bytes);
  workbook.dispose();

  OpenFile.open(file.path);
}

Future<List<List<String?>?>?> importFromFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx', 'xls'],
  );
  if (result != null) {
    File file = File(result.files.single.path!);
    List<List<String>> rows = [];
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        List<String> rowDetail = [];
        for (var element in row) {
          rowDetail.add(element?.value?.toString() ?? '');
        }
        rows.add(rowDetail);
      }
    }
    return rows;
  } else {
    // User canceled the picker
    return null;
  }
}
