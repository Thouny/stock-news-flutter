// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_company_profile_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCompanyProfileResponseModel _$GetCompanyProfileResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetCompanyProfileResponseModel(
      symbol: json['symbol'] as String,
      price: (json['price'] as num).toDouble(),
      beta: (json['beta'] as num).toDouble(),
      volAvg: json['volAvg'] as int,
      mktCap: json['mktCap'] as int,
      lastDiv: (json['lastDiv'] as num).toDouble(),
      range: json['range'] as String,
      changes: (json['changes'] as num).toDouble(),
      companyName: json['companyName'] as String,
      currency: json['currency'] as String,
      cik: json['cik'] as String,
      isin: json['isin'] as String,
      cusip: json['cusip'] as String,
      exchange: json['exchange'] as String,
      exchangeShortName: json['exchangeShortName'] as String,
      industry: json['industry'] as String,
      website: json['website'] as String,
      description: json['description'] as String,
      ceo: json['ceo'] as String,
      sector: json['sector'] as String,
      country: json['country'] as String,
      fullTimeEmployees: json['fullTimeEmployees'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zip: json['zip'] as String,
      dcfDiff: (json['dcfDiff'] as num).toDouble(),
      dcf: (json['dcf'] as num).toDouble(),
      image: json['image'] as String,
      ipoDate: json['ipoDate'] as String,
      defaultImage: json['defaultImage'] as bool,
      isEtf: json['isEtf'] as bool,
      isActivelyTrading: json['isActivelyTrading'] as bool,
      isAdr: json['isAdr'] as bool,
      isFund: json['isFund'] as bool,
    );

Map<String, dynamic> _$GetCompanyProfileResponseModelToJson(
        GetCompanyProfileResponseModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'price': instance.price,
      'beta': instance.beta,
      'volAvg': instance.volAvg,
      'mktCap': instance.mktCap,
      'lastDiv': instance.lastDiv,
      'range': instance.range,
      'changes': instance.changes,
      'companyName': instance.companyName,
      'currency': instance.currency,
      'cik': instance.cik,
      'isin': instance.isin,
      'cusip': instance.cusip,
      'exchange': instance.exchange,
      'exchangeShortName': instance.exchangeShortName,
      'industry': instance.industry,
      'website': instance.website,
      'description': instance.description,
      'ceo': instance.ceo,
      'sector': instance.sector,
      'country': instance.country,
      'fullTimeEmployees': instance.fullTimeEmployees,
      'phone': instance.phone,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'zip': instance.zip,
      'dcfDiff': instance.dcfDiff,
      'dcf': instance.dcf,
      'image': instance.image,
      'ipoDate': instance.ipoDate,
      'defaultImage': instance.defaultImage,
      'isEtf': instance.isEtf,
      'isActivelyTrading': instance.isActivelyTrading,
      'isAdr': instance.isAdr,
      'isFund': instance.isFund,
    };
