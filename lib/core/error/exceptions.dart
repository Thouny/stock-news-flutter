class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);
}

class ServerException implements Exception {
  final String message;

  const ServerException(this.message);
}

class StorageException implements Exception {
  final String message;

  const StorageException(this.message);
}
