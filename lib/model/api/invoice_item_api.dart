import 'package:flutter_capstone_project/model/invoice_model.dart';
import 'package:flutter_capstone_project/services/services.dart';

class InvoiceItemAPI {
  static Future<List<Invoice>> getInvoices() async {
    Services repo = Services();
    final response = await repo.get(url: 'invoice');
    return await Future.value(response.map<Invoice>((e) => Invoice.fromJson(e)).toList());
  }

  // static Future<Invoice> getInvoice({required int invoiceId}) async {
  //   Services repo = Services();
  //   final response = await repo.get(url: 'invoice/$invoiceId');
  //   return await Future.value(Invoice.fromJson(response));
  // }
}
