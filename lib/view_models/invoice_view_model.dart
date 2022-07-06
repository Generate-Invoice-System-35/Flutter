import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/model/api/invoice_api.dart';
import 'package:flutter_capstone_project/model/invoice_model.dart';
import 'package:flutter_capstone_project/services/services.dart';

class InvoiceViewModel with ChangeNotifier {
  ApiResponse<Invoice>? _invoice = ApiResponse(status: ApiStatus.success);
  ApiResponse<Invoice>? get invoice => _invoice;

  void changeState(ApiResponse<Invoice>? state) {
    _invoice = state;
    notifyListeners();
  }

  Future<ApiResponse<Invoice>> getInvoice({required int invoiceId}) async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await InvoiceAPI.getInvoice(invoiceId: invoiceId);

      changeState(ApiResponse<Invoice>(data: res, status: ApiStatus.success));
    } catch (e) {
      if (e is DioError) {
        if (e.response?.data != null) {
          changeState(ApiResponse(status: ApiStatus.error, message: e.response?.data['message']));
        }
      } else {
        changeState(ApiResponse(status: ApiStatus.error, message: "Error"));
      }
    }
    return Future.value(_invoice);
  }
}
