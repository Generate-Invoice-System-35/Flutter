import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/services/local_storage.dart';
import 'package:flutter_capstone_project/services/services.dart';
import 'package:flutter_capstone_project/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';

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

  Future<String?> setupToken(BuildContext? context) async {
    LocalStorage ls = LocalStorage();
    String? curToken = await ls.get(spKey: tokenKey);
    Services.assignToken(curToken);
    if (context != null && curToken != null) {
      Provider.of<AuthViewModel>(context, listen: false)
          .changeState(ApiResponse(status: ApiStatus.success, data: curToken));
    }
    return await Future.value(curToken);
  }
}
