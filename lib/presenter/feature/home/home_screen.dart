import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/feature/information/item/item_screen.dart';
import 'package:kexcel/presenter/feature/project/pdf_screen.dart';
import 'package:kexcel/presenter/feature/project/item/project_item_screen.dart';
import 'package:kexcel/presenter/feature/information/supplier/supplier_screen.dart';
import 'package:flutter/material.dart';
import 'package:kexcel/presenter/feature/information/client/client_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final features = [
      featureItem(
        onPressed: () => _routeClients(context),
        title: 'clientsManagement'.translate,
        icon: Icons.contact_mail_rounded,
        // color: Colors.yellow,
      ),
      featureItem(
        onPressed: () => _routeSuppliers(context),
        title: 'suppliersManagement'.translate,
        icon: Icons.precision_manufacturing,
        // color: Colors.blue,
      ),
      featureItem(
        onPressed: () => _routeItems(context),
        title: 'itemsManagement'.translate,
        icon: Icons.storage_rounded,
        // color: Colors.blue,
      ),
      featureItem(
        onPressed: () => _routeProjectsItem(context),
        title: 'projectsItemsManagement'.translate,
        icon: Icons.fire_truck_rounded,
        // color: Colors.black,
      ),
      featureItem(
        onPressed: () => _showPdf(context),
        title: 'PDF Sample',
        icon: Icons.picture_as_pdf,
        // color: Colors.black,
      ),
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('kExcel'),
        ),
        body: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          children: features,
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget featureItem({
    required Function() onPressed,
    required String title,
    Color color = Colors.white,
    IconData? icon,
  }) {
    return GestureDetector(
      onTap: () => onPressed.call(),
      child: Card(
        color: color,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon),
              Text(title),
            ],
          )),
        ),
      ),
    );
  }

  _routeClients(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ClientScreen(),
    ));
  }

  _routeSuppliers(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SupplierScreen(),
    ));
  }

  _routeItems(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ItemScreen(),
    ));
  }

  _routeProjectsItem(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ProjectItemScreen(),
    ));
  }
  _showPdf(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const PDFScreen(),
    ));
  }
}
