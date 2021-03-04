import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reportes/Models/report_model.dart';
import 'package:reportes/Providers/report_provider.dart';
import 'package:reportes/Widgets/drawer_widget.dart';
import 'package:reportes/Widgets/marker_widget.dart';

class LocationPage extends StatefulWidget {
  LocationPage({Key key}) : super(key: key);
  @override
  _StateLocationPage createState() => _StateLocationPage();
}

const DEFAULT_LOCATION = LatLng(-0.2704294649446027, -78.54912594779665);

class _StateLocationPage extends State<LocationPage> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng currentLocation = DEFAULT_LOCATION;
  bool isShowInfo = false;
  GoogleMapController controller;
  Set<Marker> markers = Set<Marker>();
  Set<Marker> _markers = new Set();
  List<ReportModel> _list = [];

  static final CameraPosition _kCentroLatacunga = CameraPosition(
      target: LatLng(-0.9335863141754581, -78.61500222658208),
      zoom: 15,
      bearing: 50,
      tilt: 45);

  CameraPosition _kCurrentPosition;

  @override
  void initState() {
    super.initState();
    _loading();
  }

  _fetchData() async {
    var data = await ReportProvider.getJsonReports();
    if (mounted) {
      setState(() {
        List<dynamic> results = data['docs'];
        results.forEach((element) {
          _list.add(ReportModel.fromJson(element));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('Ubicación'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: _kCentroLatacunga,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _markers,
            /*  markers: {
              Marker(
                  markerId: MarkerId(currentLocation.toString()),
                  position: currentLocation,
                  onTap: () => setState(() {
                        this.isShowInfo = !this.isShowInfo;
                      })),
            }, */
            //onTap: onTapMap,
            mapType: MapType.normal,
          ),
          Visibility(
            child: MarkerWidget('Mi ubicacion', this.currentLocation,
                'assets/images/default_user.png'),
            visible: isShowInfo,
          ),
        ],
      ),
    );
  }

  onTapMap(LatLng latLng) {
    print('ontapMap $latLng');
    createMarkers();
  }

  createMarkers() {
    markers.add(Marker(
        markerId: MarkerId('MarkerCurrent'),
        position: currentLocation,
        alpha: 1,
        anchor: const Offset(0.2, 0.2),
        draggable: true,
        infoWindow: InfoWindow(
            title: 'information',
            snippet: 'Latitude ${currentLocation.latitude}'),
        onTap: () => setState(() {
              /* controller.animateCamera(CameraUpdate.newCameraPosition(
                            CameraPosition(
                                target: LatLng(
                                    -0.28568575697798726, -78.56353314294023),
                                zoom: 10))); */
              this.isShowInfo = !this.isShowInfo;
            })));
  }

  _loading() {
    _fetchData();
    //_drawStopBus();
    //Obtiene la posición GPS del dispositivo y reubica el centro del mapa
    _determinePosition().then((value) {
      _kCurrentPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 18,
      );
      _goToCurrentPosition();
    });
  }

  /*  _drawStopBus() {
    _list.items.forEach((element) {
      Marker mark = new Marker(
          markerId: MarkerId(element.name),
          infoWindow: InfoWindow(title: element.name),
          position: element.location.getGeo());
      _markers.add(mark);
    });
    setState(() {});
  } */

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _goToCurrentPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kCurrentPosition));
    _markers.add(Marker(
        markerId: MarkerId("posicion-actual"),
        position: _kCurrentPosition.target));
    setState(() {});
  }
}
