import 'package:kexcel/presenter/common/localization.dart';
import 'package:flutter/material.dart';
import 'package:kexcel/presenter/feature/home/profile/profile_screen.dart';
import 'environment/environment_screen.dart';
import 'information/client/client_screen.dart';
import 'information/item/item_screen.dart';
import 'information/supplier/supplier_screen.dart';

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
        title: 'environmentManagement'.translate,
        icon: Icons.fire_truck_rounded,
        // color: Colors.black,
      ),
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('kExcel'),
          actions: [
            IconButton(
              onPressed: () => _routeProfile(context),
              icon: const Icon(Icons.person),
              tooltip: 'profile'.translate,
            )
          ],
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
          child: Center(
              child: Column(
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

  _routeProfile(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ProfileScreen(),
    ));
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
      builder: (context) => const EnvironmentScreen(),
    ));
  }
}
