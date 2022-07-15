class User {
  String? aud;
  String? email;
  int? exp;
  int? iat;
  int? id;

  User({this.aud, this.email, this.exp, this.iat, this.id});

  User.fromJson(Map<String, dynamic> json) {
    aud = json['aud'];
    email = json['email'];
    exp = json['exp'];
    iat = json['iat'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aud'] = aud;
    data['email'] = email;
    data['exp'] = exp;
    data['iat'] = iat;
    data['id'] = id;
    return data;
  }
}

class UserByTokenInput {
  String? token;

  UserByTokenInput({this.token});

  UserByTokenInput.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}

class UpdateUsernameInput {
  String? username;

  UpdateUsernameInput({this.username});

  UpdateUsernameInput.fromJson(Map<String, dynamic> json) {
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    return data;
  }
}

class UpdatePasswordInput {
  String? password;

  UpdatePasswordInput({this.password});

  UpdatePasswordInput.fromJson(Map<String, dynamic> json) {
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    return data;
  }
}
