import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/model/api/user_api.dart';
import 'package:flutter_capstone_project/model/common_model.dart';
import 'package:flutter_capstone_project/model/user_model.dart';
import 'package:flutter_capstone_project/services/services.dart';

class UserViewModel extends ChangeNotifier {
  ApiResponse<User?> _user = ApiResponse(status: ApiStatus.success);

  ApiResponse<User?> get user => _user;

  void changeState(ApiResponse<User?> state) {
    _user = state;
    notifyListeners();
  }

  Future<ApiResponse<User?>> getMe({required UserByTokenInput input}) async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      User res = await UserAPI.getMe(input: input);
      changeState(ApiResponse<User>(data: res, status: ApiStatus.success));
    } catch (e) {
      if (e is DioError) {
        if (e.response?.data != null) {
          changeState(ApiResponse(status: ApiStatus.error, message: e.response?.data['message']));
        }
      } else {
        changeState(ApiResponse(status: ApiStatus.error, message: "Error"));
      }
    }
    return Future.value(_user);
  }

  Future<ApiResponse<MessageResult?>> updateUsername(
      {required int id, required UpdateUsernameInput input}) async {
    ApiResponse<MessageResult?> val = ApiResponse(status: ApiStatus.success);
    try {
      MessageResult res = await UserAPI.updateUsername(id: id, input: input);
      notifyListeners();
      val.data = res;
    } catch (e) {
      if (e is DioError) {
        if (e.response?.data != null) {
          val = ApiResponse(status: ApiStatus.error, message: e.response?.data['message']);
        }
      } else {
        val = ApiResponse(status: ApiStatus.error, message: "Error");
      }
    }
    return Future.value(val);
  }

  Future<ApiResponse<MessageResult?>> updatePassword(
      {required int id, required UpdatePasswordInput input}) async {
    ApiResponse<MessageResult?> val = ApiResponse(status: ApiStatus.success);
    try {
      MessageResult res = await UserAPI.updatePassword(id: id, input: input);
      notifyListeners();
      val.data = res;
    } catch (e) {
      if (e is DioError) {
        if (e.response?.data != null) {
          val = ApiResponse(status: ApiStatus.error, message: e.response?.data['message']);
        }
      } else {
        val = ApiResponse(status: ApiStatus.error, message: "Error");
      }
    }
    return Future.value(val);
  }
}
