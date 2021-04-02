import 'dart:convert';

FeedBackModel feedBackModelFromJson(String str) =>
    FeedBackModel.fromJson(json.decode(str));
String feedBackModelToJson(FeedBackModel data) => json.encode(data.toJson());

class FeedBackModel {
  String id;
  String title;
  String body;
  String type;
  String userId;

  FeedBackModel({this.id, this.title, this.body, this.type, this.userId});
  factory FeedBackModel.fromJson(Map<String, dynamic> json) => FeedBackModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      type: json['type'],
      userId: json['userId']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'body': body, 'type': type, 'userId': userId};
}
