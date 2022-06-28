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

class RegisterResult {
  String? messages;
  Users? users;

  RegisterResult({this.messages, this.users});

  RegisterResult.fromJson(Map<String, dynamic> json) {
    messages = json['messages'];
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messages'] = messages;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    return data;
  }
}

class Users {
  int? id;
  String? username;
  String? password;
  String? createdAt;
  String? updatedAt;

  Users({this.id, this.username, this.password, this.createdAt, this.updatedAt});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['password'] = password;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

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
