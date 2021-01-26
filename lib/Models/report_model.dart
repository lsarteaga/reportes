import 'dart:convert';

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
    this.slug,
    this.avatarImage,
    this.coverImage,
  });

  String time;
  String id;
  String title;
  String description;
  String address;
  String slug;
  String avatarImage;
  String coverImage;

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        time: json["time"],
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        address: json["address"],
        slug: json["slug"],
        avatarImage: json["avatarImage"],
        coverImage: json["coverImage"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "_id": id,
        "title": title,
        "description": description,
        "address": address,
        "slug": slug,
        "avatarImage": avatarImage,
        "coverImage": coverImage,
      };
}
