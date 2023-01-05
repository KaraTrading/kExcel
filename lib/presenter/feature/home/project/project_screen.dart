import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/feature/home/information/base_information_screen.dart';
import 'package:kexcel/presenter/utils/excel_utils.dart';
import 'add/project_add_screen.dart';
import 'project_bloc.dart';
import 'project_bloc_event.dart';

class ProjectScreen extends BaseInformationScreen<ProjectBloc, ProjectEntity> {
  const ProjectScreen({super.key});

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
  BaseBlocEvent get initEvent => ProjectEventInit();

  @override
  BaseBlocEvent deleteEvent(ProjectEntity entity) => ProjectEventDelete(entity);

  @override
  Widget itemDetails(BuildContext context, ProjectEntity entity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${entity.date.year.toString().substring(2)}${entity.id}'),
            Text('${'client'.translate}: ${entity.client.name}'),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text('${'winners'.translate}: '),
              ...entity.winners
                  .map((e) => Card(
                        color: Theme.of(context).colorScheme.background,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Text(e.toString()),
                        ),
                      ))
                  .toList()
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text('${'items'.translate}: '),
              ...entity.items
                  .map((e) => Card(
                        color: Theme.of(context).colorScheme.background,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Text(e.toString()),
                        ),
                      ))
                  .toList()
            ],
          ),
        ),
      ],
    );
  }

  @override
  void editItemDetails(BuildContext context, {ProjectEntity? entity}) {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => ProjectAddScreen(entity: entity),
    ))
        .then((val) {
      callEvent(initEvent);
    });
  }

  @override
  void export() {
    final titles = [
      'id'.translate,
      'client'.translate,
      'winners'.translate,
      'itemsIds'.translate,
    ];
    exportListToFile(
        titles,
        getBloc.projects.map((e) {
          String winnersIds = '';

          for (var element in e.winners) {
            if (winnersIds.isNotEmpty) winnersIds += ', ';
            winnersIds += element.id.toString();
          }
          String itemsIds = '';
          for (var element in e.items) {
            if (itemsIds.isNotEmpty) itemsIds += ', ';
            itemsIds += element.item.id.toString();
          }

          return [
            e.id.toString(),
            e.client.name,
            winnersIds,
            itemsIds,
          ];
        }).toList(),
        'exported_projects.xlsx');
  }

  @override
  void import() {}
}
