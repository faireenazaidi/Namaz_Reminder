import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // Default base URL
  static const String _defaultBaseUrl = 'http://182.156.200.177:8011/adhanapi/';

  // Private constructor
  ApiService._internal();

  // Singleton instance
  static final ApiService _instance = ApiService._internal();

  // Factory constructor for returning the singleton instance
  factory ApiService() {
    return _instance;
  }

  // Method to perform GET request with optional base URL
  Future<dynamic> getRequest(String endpoint, {String? customBaseUrl}) async {
    final String baseUrl = customBaseUrl ?? _defaultBaseUrl; // Use customBaseUrl if provided
    try {
      final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
      return _processResponse(response);
    } catch (e) {
      _handleError(e);
    }
  }

  // Method to perform POST request with optional base URL
  Future<dynamic> postRequest(String endpoint, dynamic body, {String? customBaseUrl}) async {
    final String baseUrl = customBaseUrl ?? _defaultBaseUrl; // Use customBaseUrl if provided
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (e) {
      _handleError(e);
    }
  }

  // PUT request
  Future<dynamic> putRequest(String endpoint, dynamic body, {String? customBaseUrl}) async {
    final String baseUrl = customBaseUrl ?? _defaultBaseUrl;
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (e) {
      _handleError(e);
    }
  }

  // DELETE request
  Future<dynamic> deleteRequest(String endpoint, {String? customBaseUrl}) async {
    final String baseUrl = customBaseUrl ?? _defaultBaseUrl;
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$endpoint'));
      return _processResponse(response);
    } catch (e) {
      _handleError(e);
    }
  }

  // Multipart request for file upload
  Future<dynamic> multipartRequest(
      String endpoint, {
        required File file,
        Map<String, String>? fields,
        String? customBaseUrl,
      }) async {
    final String baseUrl = customBaseUrl ?? _defaultBaseUrl;
    try {
      final uri = Uri.parse('$baseUrl/$endpoint');
      final request = http.MultipartRequest('POST', uri);

      // Add form fields if any
      if (fields != null) {
        request.fields.addAll(fields);
      }

      // Add the file to the request
      final multipartFile = await http.MultipartFile.fromPath(
        'picture', // field name of the file in the form
        file.path,
        filename: file.path,
      );
      request.files.add(multipartFile);

      // Send the request
      final streamedResponse = await request.send();

      // Convert the response to a more manageable type
      final response = await http.Response.fromStream(streamedResponse);
      return _processResponse(response); // Use existing _processResponse
    } catch (e) {
      _handleError(e);
    }
  }

  // Method to process the API response
  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorizedException(response.body.toString());
      case 403:
        throw ForbiddenException(response.body.toString());
      case 404:
        throw NotFoundException(response.body.toString());
      case 500:
        throw InternalServerErrorException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occurred while communicating with server, status code: ${response.statusCode}');
    }
  }

  // Method to handle errors
  void _handleError(dynamic error) {
    if (error is http.ClientException) {
      throw FetchDataException('No Internet connection');
    } else {
      throw error;
    }
  }
}

class AppException implements Exception {
  final String? message;
  final String? prefix;

  AppException([this.message, this.prefix]);

  @override
  String toString() {
    return '$prefix$message';
  }
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid Request: ');
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message]) : super(message, 'Unauthorized: ');
}

class ForbiddenException extends AppException {
  ForbiddenException([String? message]) : super(message, 'Forbidden: ');
}

class NotFoundException extends AppException {
  NotFoundException([String? message]) : super(message, 'Not Found: ');
}

class InternalServerErrorException extends AppException {
  InternalServerErrorException([String? message])
      : super(message, 'Internal Server Error: ');
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error During Communication: ');
}
