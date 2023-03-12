import 'dart:convert';

class AuthUser {
  AuthUser({
    this.user,
  });

  User? user;

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
        user: User.fromJson(json["user"]),
      );
}

class User {
  int? id;
  String? name;
  String? username;
  String? email;
  dynamic profilePicture;
  int? roleId;
  String? token;
  String? address;
  String? phoneNo;
  int? favoriteNo;
  int? OrderNo;
  User(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.profilePicture,
      this.roleId,
      this.token,
      this.address,
      this.phoneNo,
      this.favoriteNo,
      this.OrderNo});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      email: json["email"],
      profilePicture: json["image_url"],
      roleId: json["role_id"],
      token: json["token"],
      address: json["address"],
      phoneNo: json["phone_no"],
      favoriteNo: json['favourite_items_count'],
      OrderNo: json['orders_count'],
    );
  }
}
