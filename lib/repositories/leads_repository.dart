import 'dart:convert';

import 'package:imoveis_app/models/lead.dart';
import 'package:imoveis_app/models/real_estate.dart';
import 'package:imoveis_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeadsRepository {
  final ApiService _apiService = ApiService();

  Future<List<Lead>> find() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? realEstateData = prefs.getString('realEstate');
      String? token = prefs.getString('token');

      if (realEstateData != null) {
        var realEstate = RealEstate.fromJson(json.decode(realEstateData));

        var res = await _apiService.get('leads?realEstateId=${realEstate.id}',
            token != null ? {"authorization": "Bearer $token"} : null);

        if(res['success']) {
          var results = res['results'] as List;
          List<Lead> leads = results.map((e) => Lead.fromJson(e)).toList();

          return leads;
        }
      }
      return [];
    } catch (error) {
      return [];
    }
  }
}