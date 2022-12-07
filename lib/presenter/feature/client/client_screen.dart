import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/feature/client/client_bloc.dart';
import 'package:kexcel/presenter/feature/client/client_bloc_event.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';

class ClientScreen extends BaseScreen<ClientBloc> {
  const ClientScreen({super.key});

  @override
  AppBar? get appBar => AppBar(title: const Text('Client Management'));

  @override
  Widget screenBody(BuildContext context) {
    callEvent(ClientEventInit());
    return DataLoadBlocBuilder<ClientBloc, List<ClientEntity>?>(
      noDataView: const NoItemWidget(),
      bloc: getBloc,
      builder: (BuildContext context, List<ClientEntity>? clients) {
        return ListView.builder(
          itemCount: clients?.length ?? 0,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () =>
                  showClientDetails(context, client: clients?[index]),
              child: Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Code: ${clients?[index].code ?? ''}'),
                          Text('Name: ${clients?[index].name ?? ''}'),
                          Text('Address: ${clients?[index].address ?? ''}'),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('BAFA ID: ${clients?[index].bafaId ?? ''}'),
                          Text('BAFA Email: ${clients?[index].bafaEmail ?? ''}'),
                          Text('BAFA Site: ${clients?[index].bafaSite ?? ''}'),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('National ID: ${clients?[index].nationalId ?? ''}'),
                          Text('Bank: ${clients?[index].bank ?? ''}'),
                          Text('Contact: ${clients?[index].contact ?? ''}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  FloatingActionButton? floatingActionButton(BuildContext context) =>
      FloatingActionButton(
        onPressed: () => showClientDetails(context),
        child: const Icon(Icons.add),
      );

  void showClientDetails(BuildContext context, {ClientEntity? client}) {
    final TextEditingController codeController =
        TextEditingController(text: client?.code ?? '');
    final TextEditingController nameController =
        TextEditingController(text: client?.name ?? '');
    final TextEditingController addressController =
        TextEditingController(text: client?.address ?? '');
    final TextEditingController nationalIdController =
        TextEditingController(text: client?.nationalId ?? '');
    final TextEditingController bafaIdController =
        TextEditingController(text: client?.bafaId ?? '');
    final TextEditingController bafaEmailController =
        TextEditingController(text: client?.bafaEmail ?? '');
    final TextEditingController bafaSiteController =
        TextEditingController(text: client?.bafaSite ?? '');
    final TextEditingController bankController =
        TextEditingController(text: client?.bank ?? '');
    final TextEditingController contactController =
        TextEditingController(text: client?.contact ?? '');

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: codeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Code',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Address',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: bafaIdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'BAFA ID',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: bafaEmailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'BAFA Email',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: bafaSiteController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'BAFA Site',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: nationalIdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'National ID',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: bankController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Bank',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: contactController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Contact',
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                  onPressed: () {
                    final newClient = ClientEntity(
                      id: client?.id ?? -1,
                      name: nameController.text,
                      code: codeController.text,
                      nationalId: nationalIdController.text,
                      address: addressController.text,
                      bafaId: bafaIdController.text,
                      bafaEmail: bafaEmailController.text,
                      bafaSite: bafaSiteController.text,
                      bank: bankController.text,
                      contact: contactController.text,
                    );
                    if (client == null) {
                      callEvent(ClientEventAddingDone(newClient));
                    } else {
                      callEvent(ClientEventEditingDone(newClient));
                    }
                  },
                  child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}
