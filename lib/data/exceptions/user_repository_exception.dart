class UserRepositoryException implements Exception {
  final String message;

  UserRepositoryException(this.message);
}

class InvalidFilterException implements Exception {
  final String message;

  InvalidFilterException(this.message);
}
