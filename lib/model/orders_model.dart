import 'package:flutter/cupertino.dart';

class MyOrder with ChangeNotifier {
  MyOrder({
    this.id,
    this.userId,
    this.total,
    this.status,
    this.createdAt,
  });

  int? id;
  int? userId;
  dynamic? total;
  String? status;
  DateTime? createdAt;

  factory MyOrder.fromJson(Map<String, dynamic> json) =>
      MyOrder(
        id: json["id"],
        userId: json["user_id"],
        total: json["total"],
        status: statusValues.map![json["status"]].toString(),
        createdAt: DateTime.parse(json["created_at"]),
      );
}

enum Status { Requested, Accepted, Completed , Rejected}

final statusValues = EnumValues({
  "requested": Status.Requested.name,
  "accepted": Status.Accepted.name,
  "completed": Status.Completed.name,
  "rejected":Status.Rejected.name,
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => MapEntry(v, k));
    }
    return reverseMap!;
  }
}
