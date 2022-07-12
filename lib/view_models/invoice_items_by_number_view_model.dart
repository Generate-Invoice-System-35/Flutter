import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/model/api/invoice_item_api.dart';
import 'package:flutter_capstone_project/model/invoice_item_model.dart';
import 'package:flutter_capstone_project/services/services.dart';

class InvoiceItemsByNumberViewModel with ChangeNotifier {
  ApiResponse<List<InvoiceItem>>? _invoiceItems = ApiResponse(status: ApiStatus.success);
  ApiResponse<List<InvoiceItem>>? get invoiceItems => _invoiceItems;

  void changeState(ApiResponse<List<InvoiceItem>>? state) {
    _invoiceItems = state;
    notifyListeners();
  }

  Future<ApiResponse<List<InvoiceItem>>> getInvoiceItemsByNumber({required String number}) async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await InvoiceItemAPI.getInvoiceItemsByNumber(number: number);

      changeState(ApiResponse<List<InvoiceItem>>(data: res, status: ApiStatus.success));
    } catch (e) {
      if (e is DioError) {
        if (e.response?.data != null) {
          changeState(ApiResponse(status: ApiStatus.error, message: e.response?.data['message']));
        }
      } else {
        changeState(ApiResponse(status: ApiStatus.error, message: "Error"));
      }
    }
    return Future.value(_invoiceItems);
  }
}
