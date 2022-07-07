class GenerateInvoicesInput {
  List<int>? ids;

  GenerateInvoicesInput({this.ids});

  GenerateInvoicesInput.fromJson(Map<String, dynamic> json) {
    ids = json['ids'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ids'] = ids;
    return data;
  }
}
