import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';
import 'package:image_picker/image_picker.dart';

import '../../dependencies/app_dependencies.dart';
import '../constants/constants.dart';

final httpServiceProvider = Provider<HttpService>((ref) {
  final dependencies = ref.read(appDependenciesProvider);
  return dependencies.httpService;
});
//USAGE
// final httpService = ref.read(httpServiceProvider);
// final response = await httpService.getItems(endpointUrl: 'your-endpoint');

class HttpService {
  final String baseUrl = MAIN_URL;

  Future<http.Response> getItems({required String endpointUrl}) async {
    return _handleRequest(() async {
      return await http.get(Uri.parse('$baseUrl/$endpointUrl'));
    });
  }

  // New getItems with queryParams method for pagination
  Future<http.Response> getItemsWithQueryParams({
    required String endpointUrl,
    Map<String, String>? queryParams, // New parameter for query parameters
  }) async {
    // Create the URI with query parameters
    final uri = Uri.parse('$baseUrl/$endpointUrl')
        .replace(queryParameters: queryParams);
    log('uri =: $uri ');

    return _handleRequest(() async {
      return await http.get(uri);
    });
  }

  Future<http.Response> addItem({
    required String endpointUrl,
    required dynamic itemData,
  }) async {
    return _handleRequest(() async {
      return await http.post(
        Uri.parse('$baseUrl/$endpointUrl'),
        body: json.encode(itemData),
        headers: _defaultHeaders,
      );
    });
  }

  Future<http.Response> updateItem({
    required String endpointUrl,
    required String itemId,
    required dynamic itemData,
  }) async {
    return _handleRequest(() async {
      return await http.put(
        Uri.parse('$baseUrl/$endpointUrl/$itemId'),
        body: json.encode(itemData),
        headers: _defaultHeaders,
      );
    });
  }

  Future<http.Response> deleteItem({
    required String endpointUrl,
    required String itemId,
  }) async {
    return _handleRequest(() async {
      return await http.delete(Uri.parse('$baseUrl/$endpointUrl/$itemId'));
    });
  }

  // New method for handling multipart form data (image or file uploads)
  Future<http.StreamedResponse> sendMultipartRequest({
    required String endpointUrl,
    required Map<String, String> fields, // Form data fields
    XFile? file, // Optional image/file to upload
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/$endpointUrl');
      final request = http.MultipartRequest('POST', uri);

      // Add form fields
      fields.forEach((key, value) {
        request.fields[key] = value;
      });

      // Add file if provided
      if (file != null) {
        final mimeType = lookupMimeType(file.path);
        final fileName = path.basename(file.path);

        request.files.add(http.MultipartFile.fromBytes(
          'file', // Field name for file
          await file.readAsBytes(),
          filename: fileName,
          contentType: mimeType != null ? MediaType.parse(mimeType) : null,
        ));
      }

      // Send the multipart request and return the streamed response
      log('Sending multipart request to: $uri');
      return await request.send();
    } catch (e) {
      log('Error sending multipart request: $e');
      return http.StreamedResponse(
        Stream.value(utf8.encode(json.encode({'message': 'Error: $e'}))),
        500,
      );
    }
  }

  // Private method for shared headers
  Map<String, String> get _defaultHeaders => {
        'Content-Type': 'application/json',
      };

  // Private method for handling requests
  Future<http.Response> _handleRequest(
      Future<http.Response> Function() requestFunction) async {
    try {
      final response = await requestFunction();
      log('_handleRequest response =: ${json.decode(response.body)} ');
      return response;
    } catch (e) {
      return http.Response(
        json.encode({'message': 'Error: ${e.toString()}'}),
        500,
      );
    }
  }
}
