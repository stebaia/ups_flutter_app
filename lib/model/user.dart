class User {
  final String email;
  final String password;
  final String token;

  User({
    required this.email,
    required this.password,
    required this.token,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        email: json['email'],
        password: json['password'],
        token: json['token'],
      );
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'token': token,
    };
  }
}
