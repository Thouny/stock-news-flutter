import 'package:json_annotation/json_annotation.dart';

part 'get_historical_stock_response_model.g.dart';

@JsonSerializable()
class GetHistoricalStockResponseModel {
  final String symbol;
  final List<HistoricalData> historical;

  const GetHistoricalStockResponseModel({
    required this.symbol,
    required this.historical,
  });

  factory GetHistoricalStockResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetHistoricalStockResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetHistoricalStockResponseModelToJson(this);
}

@JsonSerializable()
class HistoricalData {
  final String date;
  final double open;
  final double high;
  final double low;
  final double close;
  final double adjClose;
  final int volume;
  final int unadjustedVolume;
  final double change;
  final double changePercent;
  final double vwap;
  final String label;
  final double changeOverTime;

  HistoricalData({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.adjClose,
    required this.volume,
    required this.unadjustedVolume,
    required this.change,
    required this.changePercent,
    required this.vwap,
    required this.label,
    required this.changeOverTime,
  });

  factory HistoricalData.fromJson(Map<String, dynamic> json) =>
      _$HistoricalDataFromJson(json);

  Map<String, dynamic> toJson() => _$HistoricalDataToJson(this);
}
