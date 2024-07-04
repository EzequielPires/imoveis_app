import 'package:dio/dio.dart';
import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/services/api_service.dart';

class QueryAnnouncement {
  String? realEstateId;
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

  QueryAnnouncement({
    this.realEstateId,
    this.adType,
    this.city,
    this.district,
    this.input,
    this.isFeatured,
    this.order,
    this.page,
    this.realtor,
    this.state,
    this.status,
    this.type,
  });

  @override
  String toString() {
    return '?realEstateId=$realEstateId';
  }
}

class AnnouncementsRepository {
  final ApiService _apiService = ApiService();

  Future<List<Announcement>> find(QueryAnnouncement? query, String? token) async {
    try {
      print(token);
      var res = await _apiService.get('property${query.toString()}', token != null ? {"authorization": "Bearer $token"} : null);
      if (res['success']) {
        var results = res['properties'] as List;
        List<Announcement> announcements =
            results.map((e) => Announcement.fromJson(e)).toList();

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
