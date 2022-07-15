import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/model/api/invoice_api.dart';
import 'package:flutter_capstone_project/services/services.dart';

class InvoiceTotalPaginationViewModel with ChangeNotifier {
  ApiResponse<int>? _total = ApiResponse(status: ApiStatus.success);
  ApiResponse<int>? get total => _total;

  void changeState(ApiResponse<int>? state) {
    _total = state;
    notifyListeners();
  }

  Future<ApiResponse<int>> getTotalPagination() async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await InvoiceAPI.getPaginationTotal();
      changeState(ApiResponse<int>(data: res, status: ApiStatus.success));
    } catch (e) {
      if (e is DioError) {
        if (e.response?.data != null) {
          changeState(ApiResponse(status: ApiStatus.error, message: e.response?.data['message']));
        }
      } else {
        changeState(ApiResponse(status: ApiStatus.error, message: "Error"));
      }
    }
    return Future.value(_total);
  }
}
