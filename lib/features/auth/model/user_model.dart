import 'dart:convert';
import 'dart:developer';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  // Factory constructor to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    log('fromJson');

    return UserModel(
      id: json['_id'] ?? json['id'],
      name: json['name'] as String,
      email: json['email'] ??
          json[
              'createdAt'], // Make sure 'email' is used correctly or provide a default empty string
      token: json['token'] ??
          json[
              'updatedAt'], // Ensure 'token' is mapped correctly or provide a default empty string
    );
  }

  // Method to serialize UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'token': token,
    };
  }

  // Method to create a UserModel from a JSON string
  factory UserModel.fromString(String jsonString) {
    log('fromString');

    final Map<String, dynamic> json = jsonDecode(jsonString);
    log('fromString json: $json');

    return UserModel.fromJson(json);
  }

  // CopyWith method to create modified instances
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  // toString override for better logging
  @override
  String toString() {
    return '{id: $id, name: $name, email: $email, token: $token}';
  }

  // == operator override for value comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.token == token;
  }

  // hashCode override for consistent hashing
  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ email.hashCode ^ token.hashCode;
}
