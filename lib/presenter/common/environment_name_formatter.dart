import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/environment_entity.dart';

String getEnvironmentName({
  required CompanyEntity company,
  required EnvironmentEntity environment,
}) {
  if (company.id == 1) {
    return 'E-${environment.date.year.toString().substring(2)}'
        '${environment.annualId.toString().padLeft(3, "0")}'
        '-${environment.supplier?.code.substring(1) ?? '7000'}'
        '-${environment.project.date.year.toString().substring(2)}'
        '${environment.project.annualId.toString().padLeft(3, "0")}';
  }

  return '${environment.project.date.year.toString().substring(2)}'
      'P${environment.project.annualId.toString().padLeft(3, "0")}'
      '-${(environment.items.length == environment.project.items.length) ? 'AL' : environment.project.environmentsIds.indexWhere((element) => element == environment.id)}';
}
