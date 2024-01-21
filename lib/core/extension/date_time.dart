extension DateTimeExtension on DateTime {
  String get toDateString => toIso8601String().split('T')[0];
}
