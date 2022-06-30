import 'package:dio/dio.dart';
import 'package:flutter_capstone_project/model/common_model.dart';
import 'package:flutter_capstone_project/services/services.dart';

class GenerateAPI {
  static Future<MessageResult> generate(
      {required FormData input, void Function(int, int)? onSendProgress}) async {
    Services repo = Services();
    final response = await repo.post(url: 'generate', data: input, onSendProgress: onSendProgress);
    return await Future.value(MessageResult.fromJson(response));
  }
}
