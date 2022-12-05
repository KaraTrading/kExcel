
import 'package:kexcel/core/json_convertable.dart';
import 'package:kexcel/core/mappable.dart';
import 'package:kexcel/domain/entity/base_entity.dart';

import 'base_response_entity.dart';

///
/// BASE DTO CLASS FOR RESPONSE DTOs
///
abstract class BaseDto<T extends BaseEntity> implements Mappable<T> {
  /// shows implemented entities based on which api version
  /// count from 1
  /// correspond with the rest api version
  abstract final int apiVersion;
}


///
/// BASE DTO CLASS FOR REQUEST DTOs
///
abstract class BaseRequestDto implements JsonConvertible {}


class BaseResponseDTO extends BaseDto {
  int? id;
  bool? hasError;
  String? developerMessage;
  String? friendlyMessages;
  bool? isFluentQueryBuilder;
  ValidationErrors? validationErrors;

  BaseResponseDTO(
      {this.id, this.hasError, this.developerMessage, this.friendlyMessages});

  @override
  int apiVersion = 1;

  BaseResponseDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hasError = json['hasError'];
    developerMessage = json['developerMessage'];
    friendlyMessages = json['friendlyMessages'];
  }

  fillFromResponse(Map<String, dynamic> json) {
    id = json['id'];
    hasError = json['hasError'];
    developerMessage = json['developerMessage'];
    friendlyMessages = json['friendlyMessages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hasError'] = hasError;
    data['developerMessage'] = developerMessage;
    data['friendlyMessages'] = friendlyMessages;
    return data;
  }

  @override
  BaseResponseEntity map() => BaseResponseEntity(
      friendlyMessages: friendlyMessages,
      id: id,
      hasError: hasError,
      developerMessage: developerMessage);

}


class ValidationErrors {
  List<AdditionalProp>? additionalProp1;
  List<AdditionalProp>? additionalProp2;
  List<AdditionalProp>? additionalProp3;

  ValidationErrors(
      {this.additionalProp1, this.additionalProp2, this.additionalProp3});

  ValidationErrors.fromJson(Map<String, dynamic> json) {
    if (json['additionalProp1'] != null) {
      additionalProp1 = List.empty(growable: true);
      json['additionalProp1'].forEach((v) {
        additionalProp1?.add(AdditionalProp.fromJson(v));
      });
    }
    if (json['additionalProp2'] != null) {
      additionalProp2 = List.empty(growable: true);
      json['additionalProp2'].forEach((v) {
        additionalProp2?.add(AdditionalProp.fromJson(v));
      });
    }
    if (json['additionalProp3'] != null) {
      additionalProp3 = List.empty(growable: true);
      json['additionalProp3'].forEach((v) {
        additionalProp3?.add(AdditionalProp.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (additionalProp1 != null) {
      data['additionalProp1'] =
          additionalProp1?.map((v) => v.toJson()).toList();
    }
    if (additionalProp2 != null) {
      data['additionalProp2'] =
          additionalProp2?.map((v) => v.toJson()).toList();
    }
    if (additionalProp3 != null) {
      data['additionalProp3'] =
          additionalProp3?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdditionalProp {
  String? errorCode;
  String? message;
  bool? hasError;

  AdditionalProp({this.errorCode, this.message, this.hasError});

  AdditionalProp.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    message = json['message'];
    hasError = json['hasError'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['message'] = message;
    data['hasError'] = hasError;
    return data;
  }
}
