import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AppKeyValueStore {
  const AppKeyValueStore();

  /// Insert a key/value pair.
  ///
  /// Allows for a dynamic value as various storage options (eg. Hive)
  /// are able to store more than just primitive data types.
  FutureOr<void> write(String key, dynamic value);

  /// Return the value for the given `key`.
  ///
  /// If value doesn't exist, optionally return the given `defaultValue` of `<T>`.
  FutureOr<T?> read<T>(String key, {T? defaultValue});

  /// Delete a key/value pair.
  FutureOr<void> delete(String key);
}

class SecureStorage extends AppKeyValueStore {
  final FlutterSecureStorage _storage;

  const SecureStorage({required FlutterSecureStorage storage})
      : _storage = storage;

  @override
  Future<T?> read<T>(String key, {T? defaultValue}) async {
    return await _storage.read(key: key) as T? ?? defaultValue;
  }

  @override
  FutureOr<void> write(String key, dynamic value) async {
    await _storage.write(key: key, value: value.toString());
  }

  @override
  FutureOr<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}
