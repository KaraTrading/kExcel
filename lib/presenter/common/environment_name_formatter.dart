String getEnvironmentName({
  required int companyId,
  required int projectId,
  int? environmentId,
  String? supplierCode,
}) {
  if (companyId == 0) {
    return 'E-${DateTime.now().year.toString().substring(2)}'
        '${((environmentId ?? -1) + 1).toString().padLeft(3, "0")}'
        '-${supplierCode?.substring(1) ?? '7000'}'
        '-${projectId.toString().padLeft(5, "0")}';
  }

  return '${DateTime.now().year.toString().substring(2)}'
      'P${projectId.toString().padLeft(3, "0")}'
      '-${((environmentId ?? 'AL')).toString()}';
}
