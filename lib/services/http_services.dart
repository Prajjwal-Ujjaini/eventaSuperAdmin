import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../utility/constants.dart';

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
