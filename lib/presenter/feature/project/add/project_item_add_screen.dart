import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/item_entity.dart';
import 'package:kexcel/presenter/base_screen.dart';
import 'package:kexcel/presenter/data_load_bloc_builder.dart';
import 'package:kexcel/presenter/feature/project/add/project_item_add_bloc.dart';
import 'package:kexcel/presenter/feature/project/add/project_item_add_bloc_event.dart';
import 'package:kexcel/presenter/widget/no_item_widget.dart';

class ProjectItemAddScreen extends BaseScreen<ProjectItemAddBloc> {
  const ProjectItemAddScreen({super.key});

  @override
  AppBar? get appBar => AppBar();

  @override
  FloatingActionButton? floatingActionButton(BuildContext context) => null;

  @override
  Widget screenBody(BuildContext context) {
    callEvent(ProjectItemAddEventInit());
    return DataLoadBlocBuilder<ProjectItemAddBloc, List<ItemEntity>?>(
        noDataView: const NoItemWidget(),
        bloc: getBloc,
        builder: (BuildContext context, List<ItemEntity>? entities) {
          return Container();
        });
  }
}
