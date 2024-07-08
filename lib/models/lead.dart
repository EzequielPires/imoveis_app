import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/models/real_estate.dart';
import 'package:imoveis_app/models/user.dart';

class Lead {
  int id;
  String name;
  String email;
  String phone;
  String message;
  RealEstate realEstate;
  User? realtor;
  Announcement? property;
  String? type;
  String? nance;
  String? document;
  String? monthlyIncome;
  bool? married;
  String? propertyPrice;
  String? prohibited;
  String? financingTime;
  String? time;
  String? date;

  Lead({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
    required this.realEstate,
    this.date,
    this.document,
    this.financingTime,
    this.married,
    this.monthlyIncome,
    this.nance,
    this.prohibited,
    this.property,
    this.propertyPrice,
    this.realtor,
    this.time,
    this.type,
  });

  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      message: json['message'],
      realEstate: RealEstate.fromJson(json['realEstate']),
      date: json['date'],
      document: json['document'],
      financingTime: json['financingTime'],
      married: json['married'],
      monthlyIncome: json['monthlyIncome'],
      nance: json['nance'],
      prohibited: json['prohibited'],
      property: json['property'] != null ? Announcement.fromJson(json['property']) : null,
      propertyPrice: json['propertyPrice'],
      realtor: json['realtor'] != null ? User.fromJson(json['realtor']) : null,
      time: json['time'],
      type: json['type'],
    );
  }
}
