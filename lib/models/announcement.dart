import 'package:imoveis_app/models/address.dart';
import 'package:imoveis_app/models/property_type.dart';
import 'package:imoveis_app/models/real_estate.dart';
import 'package:imoveis_app/models/user.dart';

class Announcement {
  String? id;
  String? cod;
  int? views;
  String type;
  String adType;
  String? status;
  String value;
  String? thumbnail;
  List<String>? images;
  String? video;
  String? description;
  String? commission;
  String? remarks;
  String? keyInformation;
  int numberRooms;
  int numberBathrooms;
  int numberSuites;
  int numberGarages;
  String totalArea;
  String buildingArea;
  bool? allowPets;
  bool? hasPool;
  bool? hasSolarEnergy;
  bool? hasSecuritySystem;
  bool? hasElectricFence;
  bool? hasBarbecue;
  bool? hasConcertina;
  bool? hasCourt;
  bool? hasSoccerField;
  bool? hasGym;
  bool? isRegistered;
  bool? isFurnished;
  bool? isRoof;
  bool? isDeedRegistered;
  bool? showAddress;
  String? condominiumValue;
  bool? iptu;
  String? iptuValue;
  String? concierge;
  String? keyType;
  String? availability;
  User? owner;
  User? realtor;
  RealEstate? realEstate;
  Address? address;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isFeatured;

  Announcement({
    this.id,
    this.cod,
    this.views,
    required this.type,
    required this.adType,
    this.status,
    required this.value,
    this.thumbnail,
    this.images,
    this.video,
    this.description,
    this.commission,
    this.remarks,
    this.keyInformation,
    required this.numberRooms,
    required this.numberBathrooms,
    required this.numberSuites,
    required this.numberGarages,
    required this.totalArea,
    required this.buildingArea,
    this.allowPets,
    this.hasPool,
    this.hasSolarEnergy,
    this.hasSecuritySystem,
    this.hasElectricFence,
    this.hasBarbecue,
    this.hasConcertina,
    this.hasCourt,
    this.hasSoccerField,
    this.hasGym,
    this.isRegistered,
    this.isFurnished,
    this.isRoof,
    this.isDeedRegistered,
    this.showAddress,
    this.condominiumValue,
    this.iptu,
    this.iptuValue,
    this.concierge,
    this.keyType,
    this.availability,
    this.owner,
    this.realtor,
    this.realEstate,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.isFeatured,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      cod: json['cod'],
      views: json['views'],
      type: json['type'],
      adType: json['adType'],
      status: json['status'],
      value: json['value'],
      thumbnail: json['thumbnail'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      video: json['video'],
      description: json['description'],
      commission: json['commission'],
      remarks: json['remarks'],
      keyInformation: json['keyInformation'],
      numberRooms: json['numberRooms'],
      numberBathrooms: json['numberBathrooms'],
      numberSuites: json['numberSuites'],
      numberGarages: json['numberGarages'],
      totalArea: json['totalArea'],
      buildingArea: json['buildingArea'],
      allowPets: json['allowPets'],
      hasPool: json['hasPool'],
      hasSolarEnergy: json['hasSolarEnergy'],
      hasSecuritySystem: json['hasSecuritySystem'],
      hasElectricFence: json['hasElectricFence'],
      hasBarbecue: json['hasBarbecue'],
      hasConcertina: json['hasConcertina'],
      hasCourt: json['hasCourt'],
      hasSoccerField: json['hasSoccerField'],
      hasGym: json['hasGym'],
      isRegistered: json['isRegistered'],
      isFurnished: json['isFurnished'],
      isRoof: json['isRoof'],
      isDeedRegistered: json['isDeedRegistered'],
      showAddress: json['showAddress'],
      condominiumValue: json['condominiumValue'],
      iptu: json['iptu'],
      iptuValue: json['iptuValue'],
      concierge: json['concierge'],
      keyType: json['keyType'],
      availability: json['availability'],
      owner: json['owner'] != null ? User.fromJson(json['owner']) : null,
      realtor: json['realtor'] != null ? User.fromJson(json['realtor']) : null,
      realEstate: json['realEstate'] != null
          ? RealEstate.fromJson(json['realEstate'])
          : null,
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      isFeatured: json['isFeatured'],
    );
  }

  getFullTitle() {
    return '${propertyTypeData.firstWhere((item) => item.enumValue == type).name} ${adType == 'venda' ? 'à venda' : 'para alugar'} ${address?.district != null ? 'no bairro ${address?.district?.name}' : 'em ${address?.city?.name} - ${address?.state?.shortName}'}';
  }
}

class AnnouncementQuery {
  District? district;
  City? city;
  StateAddress? state;
  PropertyType? type;
  PropertyAdType? adType;

  AnnouncementQuery(
      {this.city, this.district, this.state, this.type, this.adType});

  String toFilterContent() {
    List<String> filters = [];

    if (adType != null) {
      filters.add(adType == PropertyAdType.venda ? 'Imóveis à venda' : 'Imóveis para alugar');
    }
    if (state != null) {
      filters.add(state!.name);
    }
    if (city != null) {
      filters.add(city!.name);
    }
    if (district != null) {
      filters.add(district!.name);
    }
    if (type != null) {
      filters.add(type!.enumValue);
    }

    if (filters.isEmpty) {
      return 'Sem filtros de imóvel';
    } else {
      return filters.join(', ');
    }
  }

  @override
  String toString() {
    String text = '';
    state != null ? text = '$text&state=${state?.name}' : null;
    city != null ? text = '$text&city=${city?.name}' : null;
    district != null ? text = '$text&district=${district?.name}' : null;
    type != null ? text = '$text&type=${type?.enumValue}' : null;
    adType != null ? text = '$text&adType=${adType?.name}' : null;
    return text;
  }
}
