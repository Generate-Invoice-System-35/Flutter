import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/services/local_storage.dart';
import 'package:flutter_capstone_project/services/services.dart';

const tokenKey = "auth_token";

class TokenViewModel extends ChangeNotifier {
  Future<void> setToken({required String token}) async {
    LocalStorage ls = LocalStorage();
    await ls.set(spKey: tokenKey, data: token);
    notifyListeners();
  }

  Future<void> revokeToken() async {
    LocalStorage ls = LocalStorage();
    await ls.remove(spKey: tokenKey);
    notifyListeners();
  }

  Future<String?> setupToken() async {
    LocalStorage ls = LocalStorage();
    String? curToken = await ls.get(spKey: tokenKey);
    Services.assignToken(curToken);
    return await Future.value(curToken);
  }
}
