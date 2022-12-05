

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kexcel/data/network/dto/base_response_dto.dart';

import 'exception/exception_type.dart';
import 'exception/network_exception.dart';
import 'exception/network_exception_type.dart';

class AppDioInterceptor extends Interceptor {

  final Dio dio;

  AppDioInterceptor({required this.dio});

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);

    debugPrint("############ Request ############");
    debugPrint("request URL: ${options.path}");
    debugPrint("request Body: ${options.data}");
    for (var element in options.headers.entries) {
      debugPrint("request Header $element");
    }
    debugPrint("#################################");
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var exception = _handleGNGLogicalError(response);
    if (exception != null) throw exception;
    debugPrint("############ Response ############");
    debugPrint("Request URL : ${response.requestOptions.path}");
    debugPrint("Status code : ${response.statusCode}");
    debugPrint("response body: ${response.data}");
    debugPrint("#################################");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint("############ Response ERROR ############");
    debugPrint("Request URL : ${err.requestOptions.path}");
    debugPrint("Response : ${err.response}");
    debugPrint("Error : ${err.error}");
    debugPrint("#################################");
    super.onError(err, handler);
    if (err.response?.statusCode == 401) {
      // GNGLogoutUseCase c = dependencyResolver<GNGLogoutUseCase>();
      // c.call(NoParam());
    }
  }

  DioError? _handleGNGLogicalError(Response response) {
    var statusCode = response.statusCode ?? -1;
    if (response.data != null && statusCode == 200) {
      var data = BaseResponseDTO.fromJson(response.data);
      var dataEntity = data.map();
      if (data.hasError == true) {
        return DioError(
            requestOptions: response.requestOptions,
            error: BaseNetworkException(
                type: BaseExceptionType.user,
                code: statusCode,
                networkExceptionType: BaseNetworkExceptionType.response,
                friendlyMessage: dataEntity.messages,
                developerMessage: dataEntity.developerMessage));
      }
      if (statusCode > 400) {
        return DioError(
            requestOptions: response.requestOptions,
            error: BaseNetworkException(
                type: BaseExceptionType.user,
                code: statusCode,
                networkExceptionType: BaseNetworkExceptionType.response,
                friendlyMessage: "خطای سرویس",
                developerMessage: response.statusMessage));
      }
    }
    return null;
  }
}