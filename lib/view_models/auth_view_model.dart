import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/model/api/auth_api.dart';
import 'package:flutter_capstone_project/model/auth_model.dart';
import 'package:flutter_capstone_project/services/services.dart';

class AuthViewModel extends ChangeNotifier {
  ApiResponse<String?> _token = ApiResponse(status: ApiStatus.success);

  ApiResponse<String?> get token => _token;

  void changeState(ApiResponse<String?> state) {
    _token = state;
    notifyListeners();
  }

  void logout() async {
    changeState(ApiResponse(status: ApiStatus.success, data: null));
  }

  Future<ApiResponse<String?>> register({required RegisterInput input}) async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      await AuthAPI.register(input: input);
      changeState(ApiResponse<String>(status: ApiStatus.success));
    } catch (e) {
      if (e is DioError) {
        if (e.response?.data != null) {
          changeState(ApiResponse(status: ApiStatus.error, message: e.response?.data['message']));
        }
      } else {
        changeState(ApiResponse(status: ApiStatus.error, message: "Error"));
      }
    }
    return Future.value(_token);
  }

  Future<ApiResponse<String?>> login({required LoginInput input}) async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await AuthAPI.login(input: input);
      changeState(ApiResponse<String>(data: res, status: ApiStatus.success));
    } catch (e) {
      if (e is DioError) {
        if (e.response?.data != null) {
          changeState(ApiResponse(status: ApiStatus.error, message: e.response?.data['message']));
        }
      } else {
        changeState(ApiResponse(status: ApiStatus.error, message: "Error"));
      }
    }
    return Future.value(_token);
  }
}
