import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerWidget extends StatefulWidget {
  final String title;
  final LatLng latLng;
  final String image;

  MarkerWidget(this.title, this.latLng, this.image);
  @override
  _MarkerWidgetState createState() => _MarkerWidgetState();
}

class _MarkerWidgetState extends State<MarkerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.height * 0.1,
            height: MediaQuery.of(context).size.height * 0.1,
            child: ClipOval(
              child: Image.asset(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(color: Colors.green),
                ),
                Text(
                  'Latitude: ${widget.latLng.latitude}',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  'Longitude: ${widget.latLng.longitude}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.height * 0.05,
            height: MediaQuery.of(context).size.height * 0.05,
            child: IconButton(
              icon: Icon(Icons.remove_red_eye),
              color: Colors.grey,
              tooltip: 'Ver Reporte',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
