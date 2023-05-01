import 'package:flutter/material.dart';
import 'dart:convert';

List<Notifications> notificationsFromJson(String str) =>
    List<Notifications>.from(
        json.decode(str).map((x) => Notifications.fromJson(x)));

class Notifications with ChangeNotifier {
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  dynamic? title;
  dynamic? body;
  DateTime? createdAt;

  Notifications({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.title,
    this.body,
    this.createdAt,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["id"],
        type: json["type"],
        notifiableType: json["notifiable_type"],
        notifiableId: json["notifiable_id"],
        title: Data.fromJson(json["data"]).title,
        body: Data.fromJson(json["data"]).body,
        createdAt: DateTime.parse(json["created_at"]),
      );
}

class Data {
  String? title;
  String? body;

  Data({
    this.title,
    this.body,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        body: json["body"],
      );
}
