// class TokenResult {
//   String? token;
//   User? user;
//   String? userId;

//   TokenResult({this.token, this.user, this.userId});

//   TokenResult.fromJson(Map<String, dynamic> json) {
//     token = json['token'];
//     user = json['user'] != null ? User.fromJson(json['user']) : null;
//     userId = json['userId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['token'] = token;
//     if (user != null) {
//       data['user'] = user!.toJson();
//     }
//     data['userId'] = userId;
//     return data;
//   }
// }

class LoginInput {
  String? username;
  String? password;

  LoginInput({this.username, this.password});

  LoginInput.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}

class RegisterInput {
  String? username;
  String? password;

  RegisterInput({this.username, this.password});

  RegisterInput.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
