extension Optional<K, V> on Map<K, V> {
  T? get<T>(K key, {T? defaultValue}) {
    if (containsKey(key) && (this[key] is T)) {
      return this[key] as T;
    }
    return defaultValue;
  }
}
