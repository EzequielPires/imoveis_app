import 'dart:convert';

import 'package:imoveis_app/models/real_estate.dart';
import 'package:imoveis_app/models/user.dart';
import 'package:imoveis_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CollaboratorsRepository {
  final ApiService _apiService = ApiService();

  Future<List<User>> find() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? realEstateData = prefs.getString('realEstate');
      String? token = prefs.getString('token');

      if (realEstateData != null) {
        var realEstate = RealEstate.fromJson(json.decode(realEstateData));

        var res = await _apiService.get('real-estate/${realEstate.id}/realtors',
            token != null ? {"authorization": "Bearer $token"} : null);

        if(res['success']) {
          var results = res['results'] as List;
          List<User> users = results.map((e) => User.fromJson(e)).toList();

          return users;
        }
      }
      return [];
    } catch (error) {
      return [];
    }
  }
}
