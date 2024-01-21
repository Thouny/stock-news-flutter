import 'package:json_annotation/json_annotation.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/stock_entity.dart';

part 'get_historical_stock_response_model.g.dart';

@JsonSerializable()
class GetHistoricalStockResponseModel {
  final String symbol;
  final List<HistoricalDataModel> historical;

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
class HistoricalDataModel {
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

  const HistoricalDataModel({
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

  factory HistoricalDataModel.fromJson(Map<String, dynamic> json) =>
      _$HistoricalDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoricalDataModelToJson(this);

  StockEntity get toEntity {
    return StockEntity(
      date: DateTime.parse(date),
      open: open,
      high: high,
      low: low,
      close: close,
      adjClose: adjClose,
      volume: volume,
      unadjustedVolume: unadjustedVolume,
      change: change,
      changePercent: changePercent,
      vwap: vwap,
      label: label,
      changeOverTime: changeOverTime,
    );
  }
}
