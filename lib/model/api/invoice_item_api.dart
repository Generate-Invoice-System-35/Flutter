import 'package:flutter_capstone_project/model/invoice_item_model.dart';
import 'package:flutter_capstone_project/services/services.dart';

class InvoiceItemAPI {
  static Future<List<InvoiceItem>> getInvoiceItemsByNumber({required String number}) async {
    Services repo = Services();
    final response = await repo.get(url: 'invoice-item/number/$number');
    return await Future.value(response.map<InvoiceItem>((e) => InvoiceItem.fromJson(e)).toList());
  }
}
