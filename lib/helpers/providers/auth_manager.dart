import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/services/local_storage.dart';

const tokenKey = "auth_token";

class AuthManager with ChangeNotifier {
  Future<void> setToken({required String token}) async {
    LocalStorage ls = LocalStorage();
    await ls.set(spKey: tokenKey, data: token);
    notifyListeners();
  }

  Future<String?> getToken() async {
    LocalStorage ls = LocalStorage();
    return await Future.value(await ls.get(spKey: tokenKey));
  }

  Future<void> revokeToken() async {
    LocalStorage ls = LocalStorage();
    await ls.remove(spKey: tokenKey);
    notifyListeners();
  }
}
