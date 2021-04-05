import 'dart:convert';

import 'package:reportes/Models/location_model.dart';

ReportModel reportModelFromJson(String str) =>
    ReportModel.fromJson(json.decode(str));

String reportModelToJson(ReportModel data) => json.encode(data.toJson());

class ReportModel {
  ReportModel({
    this.time,
    this.id,
    this.title,
    this.description,
    this.address,
    this.location,
    this.tag,
    this.slug,
    this.avatarImage,
    this.coverImage,
    this.idUser,
  });

  String time;
  String tag;
  String id;
  String title;
  String description;
  String address;
  Coordinates location;
  String slug;
  String avatarImage;
  String coverImage;
  String idUser;

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        time: json["time"],
        tag: json["tag"],
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        address: json["address"],
        location: Coordinates.fromJson(json["location"]),
        slug: json["slug"],
        avatarImage: json["avatarImage"],
        coverImage: json["coverImage"],
        idUser: json["idUser"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "tag": tag,
        "_id": id,
        "title": title,
        "description": description,
        "address": address,
        "location": location.toJson(),
        "slug": slug,
        "avatarImage": avatarImage,
        "coverImage": coverImage,
        "idUser": idUser,
      };
}
