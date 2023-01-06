import 'package:kexcel/domain/entity/company_entity.dart';
import 'package:kexcel/domain/entity/enquiry_entity.dart';

String getEnquiryName({
  required CompanyEntity company,
  required EnquiryEntity enquiry,
}) {
  if (company.id == 1) {
    return 'E-${enquiry.date.year.toString().substring(2)}'
        '${enquiry.annualId.toString().padLeft(3, "0")}'
        '-${enquiry.supplier?.code.substring(1) ?? '7000'}'
        '-${enquiry.project.date.year.toString().substring(2)}'
        '${enquiry.project.annualId.toString().padLeft(3, "0")}';
  }

  return '${enquiry.project.date.year.toString().substring(2)}'
      'P${enquiry.project.annualId.toString().padLeft(3, "0")}'
      '-${(enquiry.items.length == enquiry.project.items.length) ? 'AL' : (enquiry.project.enquiries.indexWhere((element) => element.id == enquiry.id) + 1)}';
}
