import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/base_entity.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';

abstract class BaseInformationScreen<B extends BaseBloc, D extends BaseEntity>
    extends BaseScreen<B> {
  const BaseInformationScreen({super.key});

  abstract final String title;

  abstract final BaseBlocEvent initEvent;

  BaseBlocEvent deleteEvent(D entity);

  Widget itemDetails(D entity);

  void import();

  void export();

  void editItemDetails(BuildContext context, {D? entity});

  @override
  AppBar? get appBar => AppBar(
        title: Text(title),
        actions: [
          IconButton(
            tooltip: 'Import From Excel',
            onPressed: () => import(),
            icon: const Icon(
              Icons.input_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          IconButton(
            tooltip: 'Export To Excel',
            onPressed: () => export(),
            icon: const Icon(
              Icons.output_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      );

  @override
  Widget screenBody(
    BuildContext context,
  ) {
    callEvent(initEvent);
    return DataLoadBlocBuilder<B, List<D>?>(
      noDataView: const NoItemWidget(),
      bloc: getBloc,
      builder: (BuildContext context, List<D>? entities) {
        return ListView.builder(
          itemCount: entities?.length ?? 0,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: itemDetails(entities![index]),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => editItemDetails(context,
                              entity: entities[index]),
                          child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5)),
                              ),
                              // height: 112,
                              child: const Center(
                                  child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ))),
                        ),
                        GestureDetector(
                          onTap: () => _showDeleteConfirmation(
                              context, entities[index]),
                          child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5)),
                              ),
                              // height: 112,
                              child: const Center(
                                  child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, D entity) {
    showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('You can not return deleted item, Are you sure?'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.grey),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                      MaterialStatePropertyAll(Colors.redAccent),
                    ),
                    onPressed: () {
                      callEvent(deleteEvent(entity));
                      Navigator.pop(context);
                    },
                    child: const Text('Delete'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  FloatingActionButton? floatingActionButton(BuildContext context) =>
      FloatingActionButton(
        onPressed: () => editItemDetails(context),
        child: const Icon(Icons.add),
      );
}
