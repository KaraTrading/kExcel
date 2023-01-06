import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/enquiry_entity.dart';
import 'package:kexcel/domain/entity/project_entity.dart';

String getProjectName({
  required CompanyEntity company,
  required ProjectEntity project,
}) {
  if (company.id == 1) {
    return 'E-${project.date.year.toString().substring(2)}'
        '${project.annualId.toString().padLeft(3, "0")}';
  }

  return '${project.date.year.toString().substring(2)}'
      'P${project.annualId.toString().padLeft(3, "0")}';
}
