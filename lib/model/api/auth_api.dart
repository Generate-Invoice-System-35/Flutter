import 'package:flutter_capstone_project/model/auth_model.dart';
import 'package:flutter_capstone_project/services/services.dart';

class AuthAPI {
  static Future<String> login({required LoginInput input}) async {
    Services repo = Services();
    final response = await repo.post(url: 'login', data: input);
    return await Future.value(response);
  }

  static Future<RegisterResult> register({required RegisterInput input}) async {
    Services repo = Services();
    final response = await repo.post(url: 'register', data: input);
    return await Future.value(RegisterResult.fromJson(response));
  }
}
