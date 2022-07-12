class InvoiceItem {
  int? id;
  int? idInvoice;
  String? product;
  String? category;
  int? qty;
  int? price;
  int? subtotal;
  DateTime? createdAt;
  DateTime? updatedAt;

  InvoiceItem(
      {this.id,
      this.idInvoice,
      this.product,
      this.category,
      this.qty,
      this.price,
      this.subtotal,
      this.createdAt,
      this.updatedAt});

  InvoiceItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idInvoice = json['id_invoice'];
    product = json['product'];
    category = json['category'];
    qty = json['qty'];
    price = json['price'];
    subtotal = json['subtotal'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_invoice'] = idInvoice;
    data['product'] = product;
    data['category'] = category;
    data['qty'] = qty;
    data['price'] = price;
    data['subtotal'] = subtotal;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
