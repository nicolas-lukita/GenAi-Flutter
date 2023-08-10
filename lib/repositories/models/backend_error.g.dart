// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackendError _$BackendErrorFromJson(Map<String, dynamic> json) => BackendError(
      type: $enumDecodeNullable(_$DioExceptionTypeEnumMap, json['type']),
      message: json['message'] as String?,
      statusCode: json['statusCode'] as int?,
    );

Map<String, dynamic> _$BackendErrorToJson(BackendError instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'type': _$DioExceptionTypeEnumMap[instance.type],
      'message': instance.message,
    };

const _$DioExceptionTypeEnumMap = {
  DioExceptionType.connectionTimeout: 'connectionTimeout',
  DioExceptionType.sendTimeout: 'sendTimeout',
  DioExceptionType.receiveTimeout: 'receiveTimeout',
  DioExceptionType.badCertificate: 'badCertificate',
  DioExceptionType.badResponse: 'badResponse',
  DioExceptionType.cancel: 'cancel',
  DioExceptionType.connectionError: 'connectionError',
  DioExceptionType.unknown: 'unknown',
};
