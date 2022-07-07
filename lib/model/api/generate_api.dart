import 'package:dio/dio.dart';
import 'package:flutter_capstone_project/model/common_model.dart';
import 'package:flutter_capstone_project/model/generate_model.dart';
import 'package:flutter_capstone_project/services/services.dart';

class GenerateAPI {
  static Future<MessageResult> generateFile(
      {required FormData input, void Function(int, int)? onSendProgress}) async {
    Services repo = Services();
    final response =
        await repo.post(url: 'generate/file', data: input, onSendProgress: onSendProgress);
    return await Future.value(MessageResult.fromJson(response));
  }

  static Future<MessageResult> generateInvoices({required GenerateInvoicesInput input}) async {
    Services repo = Services();
    final response = await repo.post(url: 'generate/invoices', data: input);
    return await Future.value(MessageResult.fromJson(response));
  }
}
