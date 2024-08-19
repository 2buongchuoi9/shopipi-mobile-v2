import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopipi_mobile_v2/utils/constants.dart';
import 'package:shopipi_mobile_v2/utils/storage.dart';

class ErrorPayload implements Exception {
  final int code;
  final String status;
  final String message;
  final dynamic data;

  ErrorPayload({
    required this.code,
    required this.status,
    required this.message,
    this.data,
  });

  @override
  String toString() {
    return 'ErrorPayload(code: $code, status: $status, message: $message, data: $data)';
  }
}

class Http {
  late String baseUrl;
  late Map<String, String> headers;

  Http() {
    baseUrl = '$API_URL/api';
    headers = {};
    _initializeHeaders();
  }

  Future<void> _initializeHeaders() async {
    final token = await accessToken.get();
    final client = await clientId.get();

    headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': token ?? '',
      'x-client-id': client ?? '',
    };
  }

  Future<Map<String, dynamic>> _handleResponse(http.Response response) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      return data;
    } else {
      final data = json.decode(response.body) as Map<String, dynamic>;
      throw ErrorPayload(
        code: data['code'] ?? response.statusCode,
        status: data['status'] ?? 'error',
        message: data['message'] ?? 'Unknown error occurred',
        data: data['data'],
      );
    }
  }

  Future<Map<String, dynamic>> get(String path,
      {Map<String, String>? queryParameters}) async {
    await _initializeHeaders();
    final uri = Uri.parse('$baseUrl/${_convert(path)}')
        .replace(queryParameters: queryParameters);
    final response = await http.get(uri, headers: headers);
    return await _handleResponse(response);
  }

  Future<Map<String, dynamic>> post(String path,
      {dynamic body, Map<String, String>? queryParameters}) async {
    await _initializeHeaders();
    final uri = Uri.parse('$baseUrl/${_convert(path)}')
        .replace(queryParameters: queryParameters);
    final response =
        await http.post(uri, headers: headers, body: json.encode(body));
    return await _handleResponse(response);
  }

  Future<Map<String, dynamic>> put(String path,
      {dynamic body, Map<String, String>? queryParameters}) async {
    await _initializeHeaders();
    final uri = Uri.parse('$baseUrl/${_convert(path)}')
        .replace(queryParameters: queryParameters);
    final response =
        await http.put(uri, headers: headers, body: json.encode(body));
    return await _handleResponse(response);
  }

  Future<Map<String, dynamic>> delete(String path,
      {Map<String, String>? queryParameters}) async {
    await _initializeHeaders();
    final uri = Uri.parse('$baseUrl/${_convert(path)}')
        .replace(queryParameters: queryParameters);
    final response = await http.delete(uri, headers: headers);
    return await _handleResponse(response);
  }

  String _convert(String path) {
    return path.startsWith('/') ? path.substring(1) : path;
  }
}
