import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imoveis_app/models/real_estate.dart';
import 'package:imoveis_app/models/user.dart';
import 'package:imoveis_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState { idle, success, error }

enum UserState { idle, logged, loggedOut }

class AuthenticationController extends ChangeNotifier {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final ApiService _apiService = ApiService();

  UserState userState = UserState.idle;
  User? user;
  RealEstate? realEstate;
  String? accessToken;
  bool isLoading = false;

  signin() async {
    try {
      isLoading = true;
      notifyListeners();

      var res = await _apiService.post(
          'authenticate',
          {
            "email": email.text,
            "password": email.text,
          },
          null);

      print(res);
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  loadUser() async {
    final shared = await SharedPreferences.getInstance();
    final member = shared.getString('user');
    final token = shared.getString('access_token');

    if (member != null) {
      user = User.fromJson(json.decode(member));
      accessToken = token;
      userState = UserState.logged;
      notifyListeners();
    } else {
      userState = UserState.loggedOut;
      notifyListeners();
    }
  }

  signup() {}
}
