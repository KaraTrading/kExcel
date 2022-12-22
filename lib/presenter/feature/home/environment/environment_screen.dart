import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/environment_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/feature/home/information/base_information_screen.dart';
import 'package:kexcel/presenter/utils/excel_utils.dart';
import 'add/environment_add_screen.dart';
import 'environment_bloc.dart';
import 'environment_bloc_event.dart';

class EnvironmentScreen extends BaseInformationScreen<EnvironmentBloc, EnvironmentEntity> {
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
                color: Colors.white,
                size: 20,
              )),
        ],
      );

  @override
  String get title => 'environmentManagement'.translate;

  @override
  BaseBlocEvent get initEvent => EnvironmentEventInit();

  @override
  BaseBlocEvent deleteEvent(EnvironmentEntity entity) => EnvironmentEventDelete(entity);

  @override
  Widget itemDetails(EnvironmentEntity entity) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${'id'.translate}: ${entity.id}'),
            Text('${'name'.translate}: ${entity.name}'),
          ],
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
    ];
    exportListToFile(
        titles,
        getBloc.environments
            .map((e) => [
                  e.projectId.toString(),
                  e.id.toString(),
                  e.name,
                  e.client?.id.toString(),
                  e.client?.name,
                  e.supplier?.id.toString(),
                  e.supplier?.name,
                ])
            .toList(),
        'exported_environments.xlsx');
  }

  @override
  void import() {}
}
