import 'package:imoveis_app/models/lead.dart';

class Dashboard {
  List<PropertyByType> types;
  List<PropertyByMonth> monthsSales;
  List<PropertyByMonth> monthsRents;
  List<Lead> leads;

  Dashboard({required this.monthsRents, required this.monthsSales, required this.types, required this.leads});

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
      types: (json['properties'] as List<dynamic>)
          .map((item) => PropertyByType.fromJson(item as Map<String, dynamic>))
          .toList(),
      monthsRents: (json['propertiesByMonth'] as List<dynamic>).where((e) => e['adType'] == 'aluguel')
          .map((item) => PropertyByMonth.fromJson(item as Map<String, dynamic>))
          .toList(),
      monthsSales: (json['propertiesByMonth'] as List<dynamic>).where((e) => e['adType'] == 'venda')
          .map((item) => PropertyByMonth.fromJson(item as Map<String, dynamic>))
          .toList(),
      leads: (json['leads'] as List<dynamic>)
          .map((item) => Lead.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class PropertyByType {
  String type;
  String totalRent;
  String totalSale;

  PropertyByType(
      {required this.totalRent, required this.totalSale, required this.type});

  factory PropertyByType.fromJson(Map<String, dynamic> json) {
    return PropertyByType(
      type: json['property_type'] as String,
      totalRent: json['num_aluguel'] as String,
      totalSale: json['num_venda'] as String,
    );
  }
}

class PropertyByMonth {
  String adType;
  String month;
  String? monthFormated;
  String count;

  PropertyByMonth(
      {required this.adType, required this.month, required this.count, this.monthFormated});

  factory PropertyByMonth.fromJson(Map<String, dynamic> json) {
    return PropertyByMonth(
      adType: json['adType'] as String,
      month: json['month'] as String,
      count: json['count'] as String,
    );
  }
}
