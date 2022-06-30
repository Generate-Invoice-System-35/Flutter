class Invoice {
  int? id;
  int? idPaymentStatus;
  String? number;
  String? buyerName;
  DateTime? invoiceDate;
  DateTime? dueDate;

  Invoice(
      {this.id, this.idPaymentStatus, this.number, this.buyerName, this.invoiceDate, this.dueDate});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPaymentStatus = json['id_payment_status'];
    number = json['number'];
    buyerName = json['buyer_name'];
    invoiceDate = DateTime.parse(json['invoice_date']);
    dueDate = DateTime.parse(json['due_date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_payment_status'] = idPaymentStatus;
    data['number'] = number;
    data['buyer_name'] = buyerName;
    data['invoice_date'] = invoiceDate;
    data['due_date'] = dueDate;
    return data;
  }
}
