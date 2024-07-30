import 'package:flutter/material.dart';
import 'package:imoveis_app/models/address.dart';
import 'package:imoveis_app/models/property_type.dart';
import 'package:imoveis_app/services/api_service.dart';

class ReportsController extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<StateAddress> states = statesData;
  StateAddress? stateAddress;
  List<City> cities = [];
  City? city;
  List<District> districts = [];
  District? district;
  List<PropertyType> types = propertyTypeData;
  PropertyType? type;
  PropertyAdType? adType = PropertyAdType.venda;
  bool isLoading = false;

  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  changeState(StateAddress state) {
    stateAddress = state;
    stateController.text = state.name;
    cities = [];
    districts = [];
    findCities(state);
    notifyListeners();
  }

  changeCity(City cityData) {
    city = cityData;
    cityController.text = cityData.name;
    districts = [];
    findDistricts(cityData);
    notifyListeners();
  }

  changeDistrict(District districtData) {
    district = districtData;
    districtController.text = districtData.name;
    notifyListeners();
  }

  changeType(PropertyType typeData) {
    type = typeData;
    typeController.text = typeData.name;
    notifyListeners();
  }

  changeAdType(PropertyAdType adTypeData) {
    adType = adTypeData;
    notifyListeners();
  }

  findCities(StateAddress state) async {
    try {
      isLoading = true;
      notifyListeners();

      var res = await _apiService.get(
          'address/cities?stateId=${state.id}&hasProperties=true', null);
      if (res['success'] && res['results'] != null) {
        var results = res['results'] as List;
        cities = results.map((e) => City.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (error) {
      cities = [];
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  findDistricts(City city) async {
    try {
      isLoading = true;
      notifyListeners();

      var res = await _apiService.get(
          'address/districts?cityId=${city.id}&hasProperties=true', null);
      if (res['success'] && res['results'] != null) {
        var results = res['results'] as List;
        districts = results.map((e) => District.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (error) {
      cities = [];
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  clearFilter() {
    city = null;
    cityController.text = '';
    stateAddress = null;
    stateController.text = '';
    district = null;
    districtController.text = '';
    type = null;
    typeController.text = '';
    notifyListeners();
  }
}
