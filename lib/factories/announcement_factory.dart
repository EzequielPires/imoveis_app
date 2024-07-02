import 'package:flutter/material.dart';
import 'package:imoveis_app/factories/address_factory.dart';
import 'package:imoveis_app/helpers/mask.dart';
import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/models/custom_file.dart';
import 'package:imoveis_app/models/property_type.dart';

class AnnouncementFactory {
  PropertyType? type;
  TextEditingController typeController = TextEditingController();
  PropertyAdType? adType;
  TextEditingController price = TextEditingController();

  int numberRooms = 0;
  int numberBathrooms = 0;
  int numberSuites = 0;
  int numberGarages = 0;

  TextEditingController description = TextEditingController();
  TextEditingController commission = TextEditingController();
  TextEditingController video = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController keyInformation = TextEditingController();

  AddressFactory addressFactory = AddressFactory();
  List<CustomFile> files = [];

  bool allowPets = false;
  bool hasPool = false;
  bool hasSolarEnergy = false;
  bool hasSecuritySystem = false;
  bool hasElectricFence = false;
  bool hasBarbecue = false;
  bool hasConcertina = false;
  bool hasCourt = false;
  bool hasSoccerField = false;
  bool hasGym = false;
  bool isRegistered = false;
  bool isFurnished = false;
  bool isFeatured = false;
  bool isRoof = false;
  bool isDeedRegistered = false;
  bool showAddress = true;

  changeType(PropertyType typeData) {
    type = type;
    typeController.text = typeData.name;
  }

  hydrate(Announcement announcement) {
    announcement.address != null
        ? addressFactory.hydrate(announcement.address!)
        : null;
    type = propertyTypeData.firstWhere((e) => e.enumValue == announcement.type);
    typeController.text = type!.name;
    price.text = maskPrice(announcement.value);

    description.text = announcement.description ?? '';
    commission.text = announcement.commission ?? '';
    remarks.text = announcement.remarks ?? '';
    video.text = announcement.video ?? '';
    keyInformation.text = announcement.keyInformation ?? '';

    numberBathrooms = announcement.numberBathrooms;
    numberGarages = announcement.numberGarages;
    numberRooms = announcement.numberRooms;
    numberSuites = announcement.numberSuites;

    files = announcement.images?.map((e) => CustomFile(url: e)).toList() ?? [];


    allowPets = announcement.allowPets ?? false;
    hasPool = announcement.hasPool ?? false;
    hasSolarEnergy = announcement.hasSolarEnergy ?? false;
    hasSecuritySystem = announcement.hasSecuritySystem ?? false;
    hasElectricFence = announcement.hasElectricFence ?? false;
    hasBarbecue = announcement.hasBarbecue ?? false;
    hasConcertina = announcement.hasConcertina ?? false;
    hasCourt = announcement.hasCourt ?? false;
    hasSoccerField = announcement.hasSoccerField ?? false;
    hasGym = announcement.hasGym ?? false;
    isRegistered = announcement.isRegistered ?? false;
    isFurnished = announcement.isFurnished ?? false;
    isFeatured = announcement.isFeatured ?? false;
    isRoof = announcement.isRoof ?? false;
    isDeedRegistered = announcement.isDeedRegistered ?? false;
    showAddress = announcement.showAddress ?? false;
  }
}
