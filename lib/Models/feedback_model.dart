import 'dart:convert';

FeedBackModel feedBackModelFromJson(String str) =>
    FeedBackModel.fromJson(json.decode(str));
String feedBackModelToJson(FeedBackModel data) => json.encode(data.toJson());

class FeedBackModel {
  final String id;
  final String title;
  final String body;
  final String type;
  final String reaction;

  FeedBackModel({this.id, this.title, this.body, this.type, this.reaction});
  factory FeedBackModel.fromJson(Map<String, dynamic> json) => FeedBackModel(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        type: json['type'],
        reaction: json['reaction'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'type': type,
        'reaction': reaction,
      };
}
