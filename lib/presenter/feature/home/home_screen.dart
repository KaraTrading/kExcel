import 'package:kexcel/presenter/feature/project/item/project_item_screen.dart';
import 'package:kexcel/presenter/feature/supplier/supplier_screen.dart';
import 'package:flutter/material.dart';
import 'package:kexcel/presenter/feature/client/client_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                    // const SizedBox(height: 20),
                    // ElevatedButton(
                    //   onPressed: () => _routeLogistic(context),
                    //   child: const SizedBox(
                    //       width: 170, child: Center(child: Text('Logistic'))),
                    // ),
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
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
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
