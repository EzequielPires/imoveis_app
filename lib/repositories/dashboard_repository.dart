import 'dart:convert';

import 'package:imoveis_app/models/dashboard.dart';
import 'package:imoveis_app/models/real_estate.dart';
import 'package:imoveis_app/repositories/announcements_repository.dart';
import 'package:imoveis_app/services/api_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardRepository {
  final ApiService _apiService = ApiService();
  final AnnouncementsRepository _announcementsRepository = AnnouncementsRepository();

  List<String> getLastSevenMonths() {
    List<String> months = [];
    DateTime now = DateTime.now();

    for (int i = 0; i < 7; i++) {
      DateTime month = DateTime(now.year, now.month - i, now.day);
      months.add(DateFormat('yyyy-MM').format(month));
    }

    return months;
  }

  Future<Dashboard?> find() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? realEstateData = prefs.getString('realEstate');
      String? token = prefs.getString('token');

      if (realEstateData != null) {
        var realEstate = RealEstate.fromJson(json.decode(realEstateData));

        var res = await _apiService.get('dashboard?realEstateId=${realEstate.id}',
            token != null ? {"authorization": "Bearer $token"} : null);


        if(res['properties'] != null) {
          Dashboard resultsFormated = Dashboard.fromJson(res);

          var announcements = await _announcementsRepository.find(QueryAnnouncement(realEstateId: realEstate.id), token);
          resultsFormated.announcements = announcements;
          return resultsFormated;
        }
      }

      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
