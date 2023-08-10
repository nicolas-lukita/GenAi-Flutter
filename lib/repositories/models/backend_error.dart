import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'backend_error.g.dart';

@JsonSerializable()
class BackendError {
  final int? statusCode;
  final DioExceptionType? type;
  final String? message;

  const BackendError({this.type, this.message, this.statusCode});

  factory BackendError.fromJson(Map<String, dynamic> json) =>
      _$BackendErrorFromJson(json);

  Map<String, dynamic> toJson() => _$BackendErrorToJson(this);
}
