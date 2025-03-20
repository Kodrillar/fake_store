import 'dart:convert';

class LoginData {
  final String username;
  final String password;

  LoginData({
    required this.username,
    required this.password,
  });

  @override
  String toString() => 'LoginData(username: $username, password: $password)';

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'username': username});
    result.addAll({'password': password});

    return result;
  }

  String toJson() => json.encode(toMap());
}
