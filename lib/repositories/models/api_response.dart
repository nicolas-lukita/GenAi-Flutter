import 'package:gen_ai_frontend/repositories/models/backend_error.dart';

class ApiResponse<T> {
  final T? response;
  final BackendError? error;
  const ApiResponse({this.response, this.error});
}
