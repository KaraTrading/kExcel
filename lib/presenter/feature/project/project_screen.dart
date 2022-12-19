import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/feature/information/base_information_screen.dart';
import 'package:kexcel/presenter/feature/project/add/project_item_add_screen.dart';
import 'package:kexcel/presenter/utils/excel_utils.dart';
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
          color: Colors.white,
          size: 20,
        )
      ),
    ],
  );

  @override
  String get title => 'projectsItemsManagement'.translate;

  @override
  BaseBlocEvent get initEvent => ProjectEventInit();

  @override
  BaseBlocEvent deleteEvent(ProjectEntity entity) => ProjectEventDelete(entity);

  @override
  Widget itemDetails(ProjectEntity entity) {
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
  void editItemDetails(BuildContext context, {ProjectEntity? entity}) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProjectItemAddScreen(entity: entity),
    ));
  }

  @override
  void export() {
    final titles = [
      'projectId'.translate,
      'id'.translate,
      'name'.translate,
      'karaProjectId'.translate,
      'clientId'.translate,
      'client'.translate,
      'winnerId'.translate,
      'winner'.translate,
      'karaPiValue'.translate,
      'Cancelled'.translate,
      'deliveryDate'.translate,
    ];
    exportListToFile(titles, getBloc.projectsItems.map((e) => [
      e.projectId.toString(),
      e.id.toString(),
      e.name,
      e.karaProjectNumber.toString(),
      e.client?.id.toString(),
      e.client?.name,
      e.winner?.id.toString(),
      e.winner?.name,
      e.karaPiValue?.toString(),
      e.isCancelled ? 'true'.translate : 'false'.translate,
      e.deliveryDate?.toIso8601String(),
    ]).toList(), 'exported_projects_items.xlsx');
  }

  @override
  void import() {

  }
}
