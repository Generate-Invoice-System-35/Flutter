import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/model/api/invoice_api.dart';
import 'package:flutter_capstone_project/model/invoice_model.dart';
import 'package:flutter_capstone_project/services/services.dart';

class InvoicesViewModel with ChangeNotifier {
  ApiResponse<List<Invoice>>? _invoices = ApiResponse(status: ApiStatus.success);
  ApiResponse<List<Invoice>>? get invoices => _invoices;

  void changeState(ApiResponse<List<Invoice>>? state) {
    _invoices = state;
    notifyListeners();
  }

  Future<ApiResponse<List<Invoice>>> getInvoices() async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await InvoiceAPI.getInvoices();

      changeState(ApiResponse<List<Invoice>>(data: res, status: ApiStatus.success));
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

  Future<ApiResponse<List<Invoice>>> getInvoicesByStatus({required int status}) async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await InvoiceAPI.getInvoicesByStatus(status: status);

      changeState(ApiResponse<List<Invoice>>(data: res, status: ApiStatus.success));
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
