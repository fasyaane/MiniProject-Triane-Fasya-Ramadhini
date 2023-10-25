
class UserModel {
  final String username;
  final String email;
  final String password;
  final String uid;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.uid,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'uid': uid,
    };
  }
}
