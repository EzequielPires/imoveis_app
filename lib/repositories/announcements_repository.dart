import 'package:dio/dio.dart';
import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/models/custom_file.dart';
import 'package:imoveis_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class ResponseAnnouncement {
  bool success;
  String message;
  Announcement? announcement;

  ResponseAnnouncement(
      {required this.success, required this.message, this.announcement});
}

class AnnouncementsRepository {
  final ApiService _apiService = ApiService();

  Future<List<Announcement>> find(
      QueryAnnouncement? query, String? token) async {
    try {
      var res = await _apiService.get('property${query.toString()}',
          token != null ? {"authorization": "Bearer $token"} : null);
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

  Future<Announcement?> findOne(String id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      var res = await _apiService.get('property/$id',
          token != null ? {"authorization": "Bearer $token"} : null);
      if (res['success']) {
        Announcement announcement = Announcement.fromJson(res['property']);

        return announcement;
      } else {
        throw Exception();
      }
    } catch (error) {
      if (error is DioException) {
        print(error.response?.data);
      } else {
        print(error);
      }
      return null;
    }
  }

  Future<ResponseAnnouncement> create(Object? data) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      var res = await _apiService
          .post('property', data, {"authorization": "Bearer $token"});
      if (res['success'] && res['property'] != null) {
        print(res['property']);
        Announcement? announcement = await findOne(res['property']['id']);
        return ResponseAnnouncement(
            message: 'Anúncio criado com sucesso.',
            success: true,
            announcement: announcement);
      } else {
        throw Exception();
      }
    } catch (error) {
      print(error);
      return ResponseAnnouncement(
          message:
              'Não foi possível criar o anúncio, tente mais tarde ou entre em contato.',
          success: false);
    }
  }

  Future<ResponseAnnouncement> update(String id, Object? data) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      var res = await _apiService
          .patch('property/$id', data, {"authorization": "Bearer $token"});
      if (res['success'] && res['property'] != null) {
        print(res['property']);
        Announcement? announcement = await findOne(res['property']['id']);
        return ResponseAnnouncement(
            message: 'Anúncio criado com sucesso.',
            success: true,
            announcement: announcement);
      } else {
        throw Exception();
      }
    } catch (error) {
      print(error);
      return ResponseAnnouncement(
          message:
              'Não foi possível criar o anúncio, tente mais tarde ou entre em contato.',
          success: false);
    }
  }

  Future<void> uploadThumbnail(String id, CustomFile file) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (file.file != null) {
      FormData data = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.file!.path),
      });

      final response = await _apiService.patchForm(
          'property/upload-thumbnail/$id',
          data,
          {"authorization": "Bearer $token"});
    }
  }

  Future<void> uploadImages(String id, List<CustomFile> files) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    for (var file in files) {
      if (file.file != null) {
        FormData data = FormData.fromMap({
          'file': await MultipartFile.fromFile(file.file!.path),
        });

        final response = await _apiService.patchForm(
            'property/upload-image/$id',
            data,
            {"authorization": "Bearer $token"});
      }
    }
  }
}
