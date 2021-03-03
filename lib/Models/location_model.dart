import 'dart:convert';

Coordinates coordinatesFromJson(String str) =>
    Coordinates.fromJson(json.decode(str));

String coordinatesToJson(Coordinates data) => json.encode(data.toJson());

class LocationsList {
  List<Coordinates> items = new List();
  LocationsList();
  LocationsList.fromJsonList(List<dynamic> jsonList) {
    for (var item in jsonList) {
      final aux = new Coordinates.fromJson(item);
      items.add(aux);
    }
  }
}

class Coordinates {
  Coordinates({
    this.latitude,
    this.longitude,
  });

  String latitude;
  String longitude;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );
  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
