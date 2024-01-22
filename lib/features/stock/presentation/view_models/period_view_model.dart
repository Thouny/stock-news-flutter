import 'package:equatable/equatable.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PeriodViewModel extends Equatable {
  final String description;
  final int duration;
  final DateTimeIntervalType intervalType;
  final double interval;
  final String label;

  const PeriodViewModel({
    required this.description,
    required this.duration,
    required this.intervalType,
    required this.interval,
    required this.label,
  });

  @override
  List<Object?> get props => [
        description,
        duration,
        intervalType,
        interval,
        label,
      ];
}
