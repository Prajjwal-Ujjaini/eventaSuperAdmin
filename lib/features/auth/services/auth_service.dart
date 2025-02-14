import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../models/api_response.dart';
import '../../../services/http_services.dart';
import '../../../utility/notification_helper.dart';
import '../../../utility/utils.dart';
import '../models/user_model.dart';

class AuthService {
  final FlutterSecureStorage _secureStorage;
  final HttpService _httpService;

  AuthService({
    required FlutterSecureStorage secureStorage,
    required HttpService httpService,
  })  : _secureStorage = secureStorage,
        _httpService = httpService;

// Refactored authentication logic with direct SnackBar notifications
  Future<bool> authenticate(String username, String password) async {
    log('authenticate');

    try {
      // Prepare the login data
      Map<String, dynamic> loginData = {
        "name": username.toLowerCase(),
        "password": password,
      };

      // Make the HTTP request
      final response = await _httpService.addItem(
        endpointUrl: 'users/login', // Update the API endpoint if needed
        itemData: loginData,
      );
      log('authenticate response =: ${response} ');
      log('authenticate response =: ${json.decode(response.body)} ');

      // Check if the response status code is in the 200 range (success)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Decode the response body from JSON
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
        log('authenticate responseBody =: ${responseBody} ');

        // Parse the response as ApiResponse
        ApiResponse apiResponse = ApiResponse.fromJson(
          responseBody,
          (json) => UserModel.fromJson(json as Map<String, dynamic>),
        );

        log('authenticate apiResponse.success =: ${apiResponse.success} ');
        log('authenticate apiResponse.message =: ${apiResponse.message} ');
        log('authenticate apiResponse.data    =: ${apiResponse.data} ');

        // Handle successful login
        if (apiResponse.success == true) {
          UserModel? user = apiResponse.data;
          log('authenticate user    =: ${user.toString()} ');

          await _secureStorage.write(key: 'auth_token', value: user?.token);
          await _secureStorage.write(key: 'user_data', value: jsonEncode(user));

          NotificationHelper.showSuccessNotification(apiResponse.message);

          print('Login success');
          return true;
        } else {
          // Handle failure from API response
          NotificationHelper.showErrorNotification(
              'Failed to Login: ${apiResponse.message}');
          return false;
        }
      } else {
        // Handle HTTP error response
        final errorBody = jsonDecode(response.body);
        NotificationHelper.showErrorNotification(
            'Error ${errorBody['message'] ?? response.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle any other exceptions
      print('Error occurred during login: $e');
      NotificationHelper.showErrorNotification('An error occurred: $e');
      return false;
    }
  }

  Future<bool> register(String name, String password) async {
    try {
      // Prepare the registration data
      Map<String, dynamic> registerData = {
        "name": name,
        "password": password,
      };

      // Make the HTTP request
      final response = await _httpService.addItem(
        endpointUrl: 'users/register', // Adjusted endpoint to match your API
        itemData: registerData,
      );

      log('register response =: ${response} ');
      log('register response =: ${json.decode(response.body)} ');

      // Check if the response status code is in the 200 range (success)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Decode the response body from JSON
        final responseBody =
            await jsonDecode(response.body) as Map<String, dynamic>;
        log('register responseBody =: ${responseBody} ');

        // Parse the response as ApiResponse
        ApiResponse apiResponse = ApiResponse.fromJson(
          responseBody,
          (json) => UserModel.fromJson(json as Map<String, dynamic>),
        );
        log('register apiResponse.success =: ${apiResponse.success} ');
        log('register apiResponse.message =: ${apiResponse.message} ');
        log('register apiResponse.data    =: ${apiResponse.data} ');

        // Handle successful registration
        if (apiResponse.success == true) {
          UserModel? user = apiResponse.data;
          log('register user    =: ${user.toString()} ');

          await _secureStorage.write(key: 'auth_token', value: user?.token);
          await _secureStorage.write(
              key: 'user_data',
              value: jsonEncode(user)); //jsonEncode(responseBody['user']));

          NotificationHelper.showSuccessNotification(apiResponse.message);

          print('Registration success');
          return true;
        } else {
          // Handle failure from API response
          NotificationHelper.showErrorNotification(
              'Failed to Register: ${apiResponse.message}');
          return false;
        }
      } else {
        // Handle HTTP error response
        final errorBody = jsonDecode(response.body);
        NotificationHelper.showErrorNotification(
            'Error ${errorBody['message'] ?? response.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle any other exceptions
      print('Error occurred during registration: $e');
      NotificationHelper.showErrorNotification('An error occurred: $e');
      return false;
    }
  }

  // Simulate password reset (forgot password)
  Future<bool> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));

    // Simulate checking for a valid email and sending a reset email
    if (email == "user@example.com") {
      // In a real-world scenario, you would send an email to the user
      return true;
    }
    return false;
  }

  // Logout user
  Future<void> logoutFromServer() async {
    log('logoutFromServer');
    await Future.delayed(const Duration(seconds: 1));
    await _secureStorage.delete(key: 'auth_token');
  }

  // Check if the user is authenticated
  Future<bool> isAuthenticated() async {
    log('AuthService isAuthenticated called ');

    final token = await _secureStorage.read(key: 'auth_token');
    log('AuthService user token: $token');

    return token != null;
  }

  Future<UserModel?> getStoredUser() async {
    log('Fetching stored user data...');

    // Read the stored user data from secure storage
    String? userData = await _secureStorage.read(key: 'user_data');
    log('Stored user data: $userData');

    // Check if userData is not empty or null using Utils.isEmpty()
    if (!Utils.isEmpty(userData)) {
      log('Utils.isEmpty(userData): ${!Utils.isEmpty(userData)}');

      // Properly decode the userData string into a Map<String, dynamic>
      return UserModel.fromJson(jsonDecode(userData!)); // Decoding directly
    }

    // Return null if no user data was found
    return null;
  }
}
