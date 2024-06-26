import 'dart:io';

import 'package:flutter/material.dart';
import 'package:imoveis_app/factories/address_factory.dart';
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
  AddressFactory addressFactory = AddressFactory();
  List<CustomFile> files = [];

  changeType(PropertyType typeData) {
    type = type;
    typeController.text = typeData.name;
  }
}
