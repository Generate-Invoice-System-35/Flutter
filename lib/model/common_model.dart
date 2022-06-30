class MessageResult {
  String? messages;

  MessageResult({this.messages});

  MessageResult.fromJson(Map<String, dynamic> json) {
    messages = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = messages;
    return data;
  }
}
