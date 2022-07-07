import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/model/api/generate_api.dart';
import 'package:flutter_capstone_project/model/common_model.dart';
import 'package:flutter_capstone_project/model/generate_model.dart';
import 'package:flutter_capstone_project/services/services.dart';

class GenerateInvoicesViewModel with ChangeNotifier {
  ApiResponse<MessageResult> _invoices = ApiResponse(status: ApiStatus.success);
  ApiResponse<MessageResult> get invoices => _invoices;

  void changeState(ApiResponse<MessageResult> state) {
    _invoices = state;
    notifyListeners();
  }

  Future<ApiResponse<MessageResult>> generateInvoices(
      {required GenerateInvoicesInput input}) async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await GenerateAPI.generateInvoices(input: input);
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
    return Future.value(_invoices);
  }
}
