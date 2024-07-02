import 'package:dio/dio.dart';
import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/services/api_service.dart';

class QueryAnnouncement {
  int? realEstateId;
  String? status;
  String? adType;
  String? type;
  String? realtor;
  String? city;
  String? state;
  String? district;
  String? page;
  String? isFeatured;
  String? input;
  String? order;
}

class AnnouncementsRepository {
  final ApiService _apiService = ApiService();

  Future<List<Announcement>> find(QueryAnnouncement? query) async {
    try {
      var res = await _apiService.get('property', null);
      if(res['success']) {
        var results = res['properties'] as List;
        List<Announcement> announcements = results.map((e) => Announcement.fromJson(e)).toList();

        return announcements;
      }
      return [];
    } catch (error) {
      if (error is DioException) {
       print(error.response?.data);
      }
      return [];
    }
  }
}
