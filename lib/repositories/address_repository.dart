import 'package:imoveis_app/models/address.dart';
import 'package:imoveis_app/services/api_service.dart';

class AddressRepository {
  final ApiService _apiService = ApiService();

  Future<List<City>> findCities(StateAddress state) async {
    try {
      var res = await _apiService.get(
          'address/cities?stateId=${state.id}&hasProperties=true', null);
      if (res['success'] && res['results'] != null) {
        var results = res['results'] as List;
        List<City> cities = results.map((e) => City.fromJson(e)).toList();

        return cities;
      }
      return [];
    } catch (error) {
      return [];
    }
  }

   Future<List<District>> findDistricts(City city) async {
    try {
      var res = await _apiService.get(
          'address/districts?cityId=${city.id}&hasProperties=true', null);
      if (res['success'] && res['results'] != null) {
        var results = res['results'] as List;
        List<District> districts = results.map((e) => District.fromJson(e)).toList();

        return districts;
      }

      return [];
    } catch (error) {
      return [];
    }
  }
}
