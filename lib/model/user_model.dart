import 'dart:convert';

class User {
  User({
    this.user,
  });

  UserClass? user;

  factory User.fromJson(Map<String, dynamic> json) => User(
        user: UserClass.fromJson(json["user"]),
      );
}

class UserClass {
  UserClass({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.emailVerifiedAt,
    required this.profilePicture,
    required this.roleId,
    required this.token,
    required this.address,
    required this.phoneNo,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  String? name;
  String? username;
  String? email;
  DateTime? emailVerifiedAt;
  dynamic profilePicture;
  int? roleId;
  String? token;
  String? address;
  String? phoneNo;
  DateTime? createdAt;
  DateTime? updatedAt;
  factory UserClass.fromJson(Map<String, dynamic> json) {
    return UserClass(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      email: json["email"],
      emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
      profilePicture: json["profile_picture"],
      roleId: json["role_id"],
      token: json["token"],
      address: json["address"],
      phoneNo: json["phone_no"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }
}
