import 'package:flutter/material.dart';
import 'package:kexcel/domain/entity/enquiry_entity.dart';
import 'package:kexcel/domain/entity/project_entity.dart';
import 'package:kexcel/presenter/base_bloc_event.dart';
import 'package:kexcel/presenter/common/enquiry_name_formatter.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/feature/home/information/base_information_screen.dart';
import 'package:kexcel/presenter/utils/excel_utils.dart';
import 'add/enquiry_add_screen.dart';
import 'enquiry_bloc.dart';
import 'enquiry_bloc_event.dart';

class EnquiryScreen
    extends BaseInformationScreen<EnquiryBloc, EnquiryEntity> {
  final ProjectEntity? project;

  const EnquiryScreen({this.project, super.key});

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
  String get title => 'enquiryManagement'.translate;

  @override
  BaseBlocEvent get initEvent => EnquiryEventInit(project);

  @override
  BaseBlocEvent deleteEvent(EnquiryEntity entity) =>
      EnquiryEventDelete(entity);

  @override
  Widget itemDetails(BuildContext context, EnquiryEntity entity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(getEnquiryName(
                company: getBloc.company, enquiry: entity)),
            Text('${'supplier'.translate}: ${entity.supplier?.name}'),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
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
          ]),
        ),
      ],
    );
  }

  @override
  void editItemDetails(BuildContext context, {EnquiryEntity? entity}) {
    if (entity?.project != null || project != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(
        builder: (context) => EnquiryAddScreen(
            entity: entity ??
                EnquiryEntity(project: project!, date: DateTime.now())),
      ))
          .then((val) {
        callEvent(initEvent);
      });
    } else {
      //TODO: show error
    }
  }

  @override
  void export() {
    final titles = [
      'projectId'.translate,
      'id'.translate,
      'code'.translate,
      'supplierId'.translate,
      'supplier'.translate,
      'itemsIds'.translate,
    ];
    exportListToFile(
        titles,
        getBloc.enquiries.map((e) {
          String itemsIds = '';
          for (var element in getBloc.enquiries) {
            if (itemsIds.isNotEmpty) itemsIds += ', ';
            itemsIds += element.id.toString();
          }
          return [
            e.project.id.toString(),
            e.id.toString(),
            getEnquiryName(company: getBloc.company, enquiry: e),
            e.supplier?.id.toString(),
            e.supplier?.name,
            itemsIds,
          ];
        }).toList(),
        'exported_enquiries.xlsx');
  }

  @override
  void import() {}
}
