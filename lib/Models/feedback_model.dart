import 'dart:convert';

FeedBackModel feedBackModelFromJson(String str) =>
    FeedBackModel.fromJson(json.decode(str));
String feedBackModelToJson(FeedBackModel data) => json.encode(data.toJson());

class FeedBackModel {
  final String id;
  final String title;
  final String body;
  final String type;

  FeedBackModel({this.id, this.title, this.body, this.type});
  factory FeedBackModel.fromJson(Map<String, dynamic> json) => FeedBackModel(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'type': type,
      };
}
