import 'package:flutter/material.dart';
import 'package:imoveis_app/models/address.dart';

class AddressFactory {
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();

  List<StateAddress> states = statesData;
  StateAddress? stateAddress;
  List<City> cities = [];
  City? city;
  List<District> districts = [];
  District? district;
  TextEditingController route = TextEditingController();
  TextEditingController complement = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController zipcode = TextEditingController();

  hydrate(Address address) {
    stateAddress = address.state;
    district = address.district;
    city = address.city;
    cityController.text = address.city?.name ?? '';
    districtController.text = address.district?.name ?? '';
    stateController.text = address.state?.name ?? '';
    route.text = address.route ?? '';
    complement.text = address.complement ?? '';
    number.text = address.number ?? '';
    zipcode.text = address.zipcode ?? '';
  }
}