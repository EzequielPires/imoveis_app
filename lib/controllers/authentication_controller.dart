import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imoveis_app/models/real_estate.dart';
import 'package:imoveis_app/models/user.dart';
import 'package:imoveis_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState { idle, success, error }

enum UserState { idle, logged, loggedInRealEstate, loggedOut }

class AuthenticationController extends ChangeNotifier {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final ApiService _apiService = ApiService();

  UserState userState = UserState.idle;
  AuthState state = AuthState.idle;
  User? user;
  RealEstate? realEstate;
  String? accessToken;
  String errorMsg = '';
  bool isLoading = false;

  signin() async {
    try {
      isLoading = true;
      notifyListeners();

      var res = await _apiService.post(
        'authenticate',
        {
          "email": email.text,
          "password": password.text,
        },
        null,
      );

      res['success'] && res['user'] != null ? setUserAuth(res) : null;
    } catch (error) {
      errorMsg = 'Credenciais inválidas';
      state = AuthState.error;
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  signinRealEstate() async {
    try {
      isLoading = true;
      notifyListeners();

      var res = await _apiService.post(
        'authenticate/real-estate',
        {
          "email": email.text,
          "password": password.text,
        },
        null,
      );

      res['success'] && res['user'] != null ? setRealEstateAuth(res) : null;
    } catch (error) {
      print(error);
      errorMsg = 'Credenciais inválidas';
      state = AuthState.error;
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  setUserAuth(Map<String, dynamic> json) async {
    final shared = await SharedPreferences.getInstance();
    user = User.fromJson(json['user']);
    realEstate = RealEstate.fromJson(json['user']['realEstate']);
    accessToken = json['token'];
    await shared.setString('user', jsonEncode(json['user']));
    await shared.setString(
        'realEstate', jsonEncode(json['user']['realEstate']));
    await shared.setString('token', json['token']);
    state = AuthState.success;
    notifyListeners();
  }

  setRealEstateAuth(Map<String, dynamic> json) async {
    final shared = await SharedPreferences.getInstance();
    realEstate = RealEstate.fromJson(json['user']);
    accessToken = json['token'];
    await shared.setString('realEstate', jsonEncode(json['user']));
    await shared.setString('token', json['token']);
    state = AuthState.success;
    notifyListeners();
  }

  loadUser() async {
    final shared = await SharedPreferences.getInstance();
    final userData = shared.getString('user');
    final realEstateData = shared.getString('realEstate');
    final token = shared.getString('token');

    if (realEstateData != null) {
      userData != null ? user = User.fromJson(json.decode(userData)) : null;
      realEstate = RealEstate.fromJson(json.decode(realEstateData));
      accessToken = token;
      userState = UserState.loggedInRealEstate;
      notifyListeners();
    } else if (userData != null) {
      user = User.fromJson(json.decode(userData));
      accessToken = token;
      userState = UserState.logged;
      notifyListeners();
    } else {
      userState = UserState.loggedOut;
      notifyListeners();
    }
  }

  signup() {}

  Future<void> signout() async {
    try {
      final shared = await SharedPreferences.getInstance();
      await shared.remove('user');
      await shared.remove('realEstate');
      await shared.remove('token');
      userState = UserState.loggedOut;
      user = null;
      notifyListeners();
    } catch (error) {
      notifyListeners();
    }
  }
}
