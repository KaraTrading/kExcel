import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/base_entity.dart';
import 'package:kexcel/presenter/base_bloc.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';

abstract class BaseInformationScreen<B extends BaseBloc, D extends BaseEntity>
    extends BaseScreen<B> {
  const BaseInformationScreen({super.key});

  abstract final String title;

  abstract final BaseBlocEvent initEvent;

  BaseBlocEvent deleteEvent(D entity);

  Widget itemDetails(BuildContext context, D entity);

  void import();

  void export();

  void editItemDetails(BuildContext context, {D? entity});

  @override
  AppBar? get appBar => AppBar(
        title: Text(title),
        actions: [
          IconButton(
            tooltip: 'importFromExcel'.translate,
            onPressed: () => import(),
            icon: const Icon(
              Icons.input_rounded,
              size: 20,
            ),
          ),
          IconButton(
            tooltip: 'exportToExcel'.translate,
            onPressed: () => export(),
            icon: const Icon(
              Icons.output_rounded,
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
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: itemDetails(context, entities![index]),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () => editItemDetails(context,
                                    entity: entities[index]),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(5)),
                                    ),
                                    // height: 112,
                                    child: const Center(
                                        child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ))),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () => _showDeleteConfirmation(
                                    context, entities[index]),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(5)),
                                    ),
                                    // height: 112,
                                    child: const Center(
                                        child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ))),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('deleteConfirmation'.translate),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'cancel'.translate,
                      style: Theme.of(context).primaryTextTheme.titleSmall,
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.secondary),
                    ),
                    onPressed: () {
                      callEvent(deleteEvent(entity));
                      Navigator.pop(context);
                    },
                    child: Text(
                      'delete'.translate,
                      style: Theme.of(context).primaryTextTheme.titleSmall,
                    ),
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
