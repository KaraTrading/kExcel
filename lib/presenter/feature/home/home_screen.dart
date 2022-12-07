import 'dart:io';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;
import 'package:flutter/material.dart';
import 'package:kexcel/presenter/feature/client/client_screen.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xl;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('kExcel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _routeClient(context),
                    child: const SizedBox(
                        width: 170, child: Center(child: Text('Clients'))),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _routeSupplier(context),
                    child: const SizedBox(
                        width: 170, child: Center(child: Text('Supplier'))),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _routeLogistic(context),
                    child: const SizedBox(
                        width: 170, child: Center(child: Text('Logistic'))),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    onPressed: () => _routeProjectsItem(context),
                    child: const SizedBox(
                        width: 170,
                        child: Center(child: Text('Projects Item'))),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black87),
              ),
              onPressed: () => _exportExcel(),
              child: SizedBox(
                width: 170,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Text('Export to Excel'),
                    SizedBox(width: 6),
                    Icon(
                      Icons.output_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _routeClient(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ClientScreen(),
    ));
  }

  _routeSupplier(BuildContext context) {
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => const ClientScreen(),
    // ));
  }

  _routeLogistic(BuildContext context) {
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => const ClientScreen(),
    // ));
  }

  _routeProjectsItem(BuildContext context) {
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => const ClientScreen(),
    // ));
  }

  _exportExcel() async {
    // Create a new Excel document.
    final xl.Workbook workbook = xl.Workbook();
    // Accessing worksheet via index.
    final xl.Worksheet sheet = workbook.worksheets[0];
    // Add Text.
    sheet.getRangeByName('A1').setText('Hello World');
    // Add Number
    sheet.getRangeByName('A3').setNumber(44);
    // Add DateTime
    sheet.getRangeByName('A5').setDateTime(DateTime(2020, 12, 12, 1, 10, 20));
    // Save the document.
    final List<int> bytes = workbook.saveAsStream();
    final directory = await getApplicationDocumentsDirectory();
    File('${directory.path}/a.xlsx').writeAsBytes(bytes);
    //Dispose the workbook.
    workbook.dispose();
  }
}
