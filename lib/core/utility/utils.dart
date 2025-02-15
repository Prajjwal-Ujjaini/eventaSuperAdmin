class Utils {
  // Check if an object is empty
  static bool isEmpty(dynamic value) {
    if (value == null) return true;

    if (value is String) {
      return value.trim().isEmpty; // Check if string is empty
    } else if (value is List || value is Set || value is Iterable) {
      return value.isEmpty; // Check if List, Set, or Iterable is empty
    } else if (value is Map) {
      return value.isEmpty; // Check if Map is empty
    } else if (value is int || value is double) {
      return value == 0; // Consider int or double empty if it's 0
    } else if (value is bool) {
      return !value; // Check if boolean is false (considered empty)
    } else if (value is DateTime) {
      return value.millisecondsSinceEpoch == 0; // Check if DateTime is empty
    } else {
      return _checkCustomObjectEmpty(value); // Check if object is custom
    }
  }

  // Check if a custom object is empty based on its fields
  static bool _checkCustomObjectEmpty(dynamic value) {
    // Check for null fields in custom objects
    var mirror = value.runtimeType.toString();
    if (mirror != 'Null' && mirror.isNotEmpty) {
      return false; // If custom object is not null and has some data
    }
    return true; // Else return true for empty custom objects
  }

  // Check if JSON object is empty
  static bool isJsonEmpty(Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) return true;
    return false;
  }
}
