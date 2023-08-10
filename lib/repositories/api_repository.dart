import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gen_ai_frontend/repositories/models/api_response.dart';
import 'package:gen_ai_frontend/repositories/models/backend_error.dart';

const iosBaseUrl = "http://127.0.0.1:5000"; //for iOS
const androidBaseUrl = "http://10.0.2.2:5000"; //for Android
String get baseUrl {
  if (Platform.isIOS) {
    return iosBaseUrl;
  } else if (Platform.isAndroid) {
    return androidBaseUrl;
  }
  return iosBaseUrl;
}

class ApiRepository {
  final Dio api;
  ApiRepository({Dio? dio, BaseOptions? options, Interceptor? interceptor})
      : api = dio ?? Dio() {
    api.options.baseUrl = baseUrl;
  }

  Future<ApiResponse<Map<String, dynamic>>> answerQuery(
      String question,
      String userId,
      String persona,
      String language,
      List<dynamic> conversationHistory) async {
    try {
      final body = {
        "question": question,
        "user_id": userId,
        "persona": persona,
        "language": language,
        "conversation_history": conversationHistory
      };
      final response = await api.post('/answer-query', data: jsonEncode(body));
      final Map<String, dynamic> data = response.data;
      return ApiResponse(response: data);
    } on DioException catch (e) {
      final backendError = _handleError(e);
      return ApiResponse(error: backendError);
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> calculationQuery(
    String question,
    String result,
    String userId,
    String persona,
    String language,
  ) async {
    try {
      final body = {
        "result": result,
        "question": question,
        "user_id": userId,
        "persona": persona,
        "language": language,
      };
      final response =
          await api.post('/calculation-query', data: jsonEncode(body));
      final Map<String, dynamic> data = response.data;
      return ApiResponse(response: data);
    } on DioException catch (e) {
      final backendError = _handleError(e);
      return ApiResponse(error: backendError);
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> reasoningQuery(
    String result,
    String userId,
    String persona,
    String language,
  ) async {
    try {
      final body = {
        "result": result,
        "user_id": userId,
        "persona": persona,
        "language": language,
      };
      final response =
          await api.post('/reasoning-query', data: jsonEncode(body));
      final Map<String, dynamic> data = response.data;
      return ApiResponse(response: data);
    } on DioException catch (e) {
      final backendError = _handleError(e);
      return ApiResponse(error: backendError);
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> generatedQuestionsQuery(
    String result,
    String language,
  ) async {
    try {
      final body = {
        "result": result,
        "language": language,
      };
      final response =
          await api.post('/generated-questions-query', data: jsonEncode(body));
      final Map<String, dynamic> data = response.data;
      return ApiResponse(response: data);
    } on DioException catch (e) {
      final backendError = _handleError(e);
      return ApiResponse(error: backendError);
    }
  }

  Future<ApiResponse<Response>> getUser(String userId) async {
    try {
      final response = await api.get('/user/$userId');
      return ApiResponse(response: response);
    } on DioException catch (e) {
      final backendError = _handleError(e);
      return ApiResponse(error: backendError);
    }
  }

  BackendError _handleError(DioException e) {
    if (e.response != null) {
      final backendError = BackendError(
          message: e.message, statusCode: e.response!.statusCode, type: e.type);
      return backendError;
    } else {
      return const BackendError(message: 'unknown error');
    }
  }
}
