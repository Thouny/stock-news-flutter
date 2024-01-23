import 'package:json_annotation/json_annotation.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';

part 'get_company_profile_response_model.g.dart';

@JsonSerializable()
class GetCompanyProfileResponseModel {
  final String symbol;
  final double price;
  final double beta;
  final int volAvg;
  final int mktCap;
  final double lastDiv;
  final String range;
  final double changes;
  final String companyName;
  final String currency;
  final String cik;
  final String isin;
  final String cusip;
  final String exchange;
  final String exchangeShortName;
  final String industry;
  final String website;
  final String description;
  final String ceo;
  final String sector;
  final String country;
  final String fullTimeEmployees;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String zip;
  final double dcfDiff;
  final double dcf;
  final String image;
  final String ipoDate;
  final bool defaultImage;
  final bool isEtf;
  final bool isActivelyTrading;
  final bool isAdr;
  final bool isFund;

  const GetCompanyProfileResponseModel({
    required this.symbol,
    required this.price,
    required this.beta,
    required this.volAvg,
    required this.mktCap,
    required this.lastDiv,
    required this.range,
    required this.changes,
    required this.companyName,
    required this.currency,
    required this.cik,
    required this.isin,
    required this.cusip,
    required this.exchange,
    required this.exchangeShortName,
    required this.industry,
    required this.website,
    required this.description,
    required this.ceo,
    required this.sector,
    required this.country,
    required this.fullTimeEmployees,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    required this.dcfDiff,
    required this.dcf,
    required this.image,
    required this.ipoDate,
    required this.defaultImage,
    required this.isEtf,
    required this.isActivelyTrading,
    required this.isAdr,
    required this.isFund,
  });

  factory GetCompanyProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetCompanyProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetCompanyProfileResponseModelToJson(this);

  CompanyEntity get toEntity {
    return CompanyEntity(
      symbol: symbol,
      currency: currency,
      price: price,
      beta: beta,
      volAvg: volAvg,
      mktCap: mktCap,
      lastDiv: lastDiv,
      range: range,
      changes: changes,
      companyName: companyName,
      cik: cik,
      isin: isin,
      cusip: cusip,
      exchange: exchange,
      exchangeShortName: exchangeShortName,
      industry: industry,
      website: website,
      description: description,
      ceo: ceo,
      sector: sector,
      country: country,
      fullTimeEmployees: fullTimeEmployees,
      phone: phone,
      address: address,
      city: city,
      state: state,
      zip: zip,
      dcfDiff: dcfDiff,
      dcf: dcf,
      image: image,
      ipoDate: ipoDate,
      defaultImage: defaultImage,
      isEtf: isEtf,
      isActivelyTrading: isActivelyTrading,
      isAdr: isAdr,
      isFund: isFund,
    );
  }
}
