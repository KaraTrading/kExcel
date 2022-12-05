import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/client_entity.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/feature/client/client_bloc.dart';
import 'package:kexcel/presenter/feature/client/client_bloc_event.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';

class ClientScreen extends BaseScreen<ClientBloc> {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  AppBar? get appBar => AppBar();

  @override
  Widget screenBody(BuildContext context) {
    callEvent(ClientEventSearch(''));
    return DataLoadBlocBuilder(
      noDataView: const NoItemWidget(),
      bloc: getBloc,
      builder: (context, List<ClientEntity>? clients) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: Text(clients?[index].name ?? ''),
            );
          },
        );
      },
    );
  }

  @override
  FloatingActionButton? floatingActionButton(BuildContext context) => FloatingActionButton(
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) => addClient(),
        ),
        child: const Icon(Icons.add),
      );

  Widget addClient() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (text) => callEvent(ClientEventAddingNameChanged(text)),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Name',
            ),
          ),
          ElevatedButton(
              onPressed: () => callEvent(ClientEventAddingDone()),
              child: const Text('Save'))
        ],
      ),
    );
  }
}
