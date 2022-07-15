import 'package:flutter_capstone_project/model/common_model.dart';
import 'package:flutter_capstone_project/model/user_model.dart';
import 'package:flutter_capstone_project/services/services.dart';

class UserAPI {
  static Future<User> getMe({required UserByTokenInput input}) async {
    Services repo = Services();
    final response = await repo.post(url: 'user/token', data: input);
    return await Future.value(User.fromJson(response));
  }

  static Future<MessageResult> updateUsername(
      {required int id, required UpdateUsernameInput input}) async {
    Services repo = Services();
    final response = await repo.put(url: 'user/update/username/$id', data: input);
    return await Future.value(MessageResult.fromJson(response));
  }

  static Future<MessageResult> updatePassword(
      {required int id, required UpdatePasswordInput input}) async {
    Services repo = Services();
    final response = await repo.put(url: 'user/update/password/$id', data: input);
    return await Future.value(MessageResult.fromJson(response));
  }
}
