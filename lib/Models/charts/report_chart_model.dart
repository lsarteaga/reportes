// To parse this JSON data, do
//
//     final reportChartModel = reportChartModelFromJson(jsonString);

import 'dart:convert';

import 'dart:ui';

ReportChartModel reportChartModelFromJson(String str) =>
    ReportChartModel.fromJson(json.decode(str));

String reportChartModelToJson(ReportChartModel data) =>
    json.encode(data.toJson());

class ReportChartModel {
  ReportChartModel({
    this.reportValue,
    this.type,
    this.colorVal,
  });

  int reportValue;
  String type;
  Color colorVal;

  factory ReportChartModel.fromJson(Map<String, dynamic> json) =>
      ReportChartModel(
        reportValue: json["reportValue"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "reportValue": reportValue,
        "type": type,
      };
}
