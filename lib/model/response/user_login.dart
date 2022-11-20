class UserLogin {
  final String email;
  final String password;

  UserLogin({
    required this.email,
    required this.password,
  });

  factory UserLogin.fromMap(Map<String, dynamic> json) => UserLogin(
        email: json['email'],
        password: json['password'],
      );
  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password};
  }
}
