import 'package:kexcel/domain/entity/base_entity.dart';


class BaseResponseEntity extends BaseEntity {
  late int? id;
  late bool? hasError;
  late String? developerMessage;
  late String? friendlyMessages;

  BaseResponseEntity(
      {this.id, this.hasError, this.developerMessage, this.friendlyMessages});

  String get messages {
    return friendlyMessages ?? "نامشخص";
  }
}
