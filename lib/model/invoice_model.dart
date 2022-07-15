class Invoice {
  int? id;
  int? idPaymentStatus;
  String? number;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  String? description;
  DateTime? invoiceDate;
  DateTime? dueDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  Invoice(
      {this.id,
      this.idPaymentStatus,
      this.number,
      this.name,
      this.email,
      this.phoneNumber,
      this.address,
      this.description,
      this.invoiceDate,
      this.dueDate,
      this.createdAt,
      this.updatedAt});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPaymentStatus = json['id_payment_status'];
    number = json['number'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    description = json['description'];
    invoiceDate = DateTime.parse(json['invoice_date']);
    dueDate = DateTime.parse(json['due_date']);
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_payment_status'] = idPaymentStatus;
    data['number'] = number;
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['address'] = address;
    data['description'] = description;
    data['invoice_date'] = invoiceDate;
    data['due_date'] = dueDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class InvoiceByPageInput {
  int? page;

  InvoiceByPageInput({this.page});

  InvoiceByPageInput.fromJson(Map<String, dynamic> json) {
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    return data;
  }
}
