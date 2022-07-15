import 'package:flutter_capstone_project/model/invoice_model.dart';
import 'package:flutter_capstone_project/services/services.dart';

class InvoiceAPI {
  static Future<List<Invoice>> getInvoices() async {
    Services repo = Services();
    final response = await repo.get(url: 'invoice');
    return await Future.value(response.map<Invoice>((e) => Invoice.fromJson(e)).toList());
  }

  static Future<Invoice> getInvoice({required int invoiceId}) async {
    Services repo = Services();
    final response = await repo.get(url: 'invoice/$invoiceId');
    return await Future.value(Invoice.fromJson(response));
  }

  static Future<List<Invoice>> getInvoicesByStatus(
      {required int status, required InvoiceByPageInput input}) async {
    Services repo = Services();
    final response = await repo.post(url: 'invoice/status/$status', data: input);
    return await Future.value(response.map<Invoice>((e) => Invoice.fromJson(e)).toList());
  }

  static Future<List<Invoice>> getInvoicesByPagination({required InvoiceByPageInput input}) async {
    Services repo = Services();
    final response = await repo.post(url: 'invoice/pagination', data: input);
    return await Future.value(response.map<Invoice>((e) => Invoice.fromJson(e)).toList());
  }

  static Future<int> getPaginationTotal() async {
    Services repo = Services();
    final response = await repo.get(url: 'invoice/pagination/total');
    return await Future.value(response);
  }
}
