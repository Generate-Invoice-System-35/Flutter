import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/model/api/generate_api.dart';
import 'package:flutter_capstone_project/model/common_model.dart';
import 'package:flutter_capstone_project/services/services.dart';

class GenerateFileViewModel with ChangeNotifier {
  ApiResponse<MessageResult> _file = ApiResponse(status: ApiStatus.success);
  ApiResponse<MessageResult> get file => _file;

  void changeState(ApiResponse<MessageResult> state) {
    _file = state;
    notifyListeners();
  }

  Future<ApiResponse<MessageResult>> generateFile(
      {required FormData formData, void Function(int, int)? onSendProgress}) async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await GenerateAPI.generateFile(input: formData, onSendProgress: onSendProgress);
      changeState(ApiResponse<MessageResult>(data: res, status: ApiStatus.success));
    } catch (e) {
      if (e is DioError) {
        if (e.response?.data != null) {
          changeState(ApiResponse(status: ApiStatus.error, message: e.response?.data['message']));
        }
      } else {
        changeState(ApiResponse(status: ApiStatus.error, message: "Error"));
      }
    }
    return Future.value(_file);
  }
}
