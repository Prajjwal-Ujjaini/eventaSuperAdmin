class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
  });

  // Factory constructor to deserialize from JSON
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json)? fromJsonT,
  ) {
    return ApiResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null ? fromJsonT!(json['data']) : null,
    );
  }

  // Method to serialize to JSON
  Map<String, dynamic> toJson(Object Function(T? value)? toJsonT) {
    return {
      'success': success,
      'message': message,
      'data': data != null ? toJsonT!(data) : null,
    };
  }

  // CopyWith method to create modified instances
  ApiResponse<T> copyWith({
    bool? success,
    String? message,
    T? data,
  }) {
    return ApiResponse<T>(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  // toString override for better logging
  @override
  String toString() {
    return 'ApiResponse(success: $success, message: $message, data: $data)';
  }

  // == operator override for value comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiResponse<T> &&
        other.success == success &&
        other.message == message &&
        other.data == data;
  }

  // hashCode override for consistent hashing
  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}
