import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/environment_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/feature/home/information/base_information_screen.dart';
import 'package:kexcel/presenter/utils/excel_utils.dart';
import 'add/environment_add_screen.dart';
import 'environment_bloc.dart';
import 'environment_bloc_event.dart';

class EnvironmentScreen
    extends BaseInformationScreen<EnvironmentBloc, EnvironmentEntity> {
  const EnvironmentScreen({super.key});

  @override
  AppBar? get appBar => AppBar(
        title: Text(title),
        actions: [
          IconButton(
              tooltip: 'exportToExcel'.translate,
              onPressed: () => export(),
              icon: const Icon(
                Icons.output_rounded,
                size: 20,
              )),
        ],
      );

  @override
  String get title => 'environmentManagement'.translate;

  @override
  BaseBlocEvent get initEvent => EnvironmentEventInit();

  @override
  BaseBlocEvent deleteEvent(EnvironmentEntity entity) =>
      EnvironmentEventDelete(entity);

  @override
  Widget itemDetails(BuildContext context, EnvironmentEntity entity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${entity.id}: ${entity.name}'),
            Text('${'supplier'.translate}: ${entity.supplier?.name}'),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            Text('${'items'.translate}: '),
            ...entity.items
                    ?.map((e) => Card(
                          color: Theme.of(context).colorScheme.background,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Text(e.name),
                          ),
                        ))
                    .toList() ??
                []
          ]),
        ),
      ],
    );
  }

  @override
  void editItemDetails(BuildContext context, {EnvironmentEntity? entity}) {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => EnvironmentAddScreen(entity: entity),
    ))
        .then((val) {
      callEvent(initEvent);
    });
  }

  @override
  void export() {
    final titles = [
      'projectId'.translate,
      'id'.translate,
      'name'.translate,
      'clientId'.translate,
      'client'.translate,
      'supplierId'.translate,
      'supplier'.translate,
      'itemsIds'.translate,
    ];
    exportListToFile(
        titles,
        getBloc.environments.map((e) {
          String itemsIds = '';
          for (var element in getBloc.environments) {
            if (itemsIds.isNotEmpty) itemsIds += ', ';
            itemsIds += element.id.toString();
          }
          return [
            e.projectId.toString(),
            e.id.toString(),
            e.name,
            e.client?.id.toString(),
            e.client?.name,
            e.supplier?.id.toString(),
            e.supplier?.name,
            itemsIds,
          ];
        }).toList(),
        'exported_environments.xlsx');
  }

  @override
  void import() {}
}
