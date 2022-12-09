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
        onPressed: () => _routeClient(context),
        title: 'Clients',
        icon: Icons.contact_mail_rounded,
        // color: Colors.yellow,
      ),
      featureItem(
        onPressed: () => _routeSupplier(context),
        title: 'Suppliers',
        icon: Icons.precision_manufacturing,
        // color: Colors.blue,
      ),
      featureItem(
        onPressed: () => _routeProjectsItem(context),
        title: 'Projects Items',
        icon: Icons.format_list_numbered_rounded,
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

  _routeClient(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ClientScreen(),
    ));
  }

  _routeSupplier(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SupplierScreen(),
    ));
  }

  _routeLogistic(BuildContext context) {
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => const ClientScreen(),
    // ));
  }

  _routeProjectsItem(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ProjectItemScreen(),
    ));
  }
}
