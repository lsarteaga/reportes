import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reportes/Widgets/drawer_widget.dart';
import 'package:reportes/Widgets/marker_widget.dart';

class LocationPage extends StatefulWidget {
  LocationPage({Key key}) : super(key: key);
  @override
  _StateLocationPage createState() => _StateLocationPage();
}

const DEFAULT_LOCATION = LatLng(-0.2704294649446027, -78.54912594779665);

class _StateLocationPage extends State<LocationPage>
    with AutomaticKeepAliveClientMixin {
  LatLng currentLocation = DEFAULT_LOCATION;
  bool isShowInfo = false;
  GoogleMapController controller;
  Set<Marker> markers = Set<Marker>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('Ubicación'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: currentLocation, zoom: 15, bearing: 50, tilt: 45),
            onMapCreated: onMapCreated,
            markers: {
              Marker(
                  markerId: MarkerId(currentLocation.toString()),
                  position: currentLocation,
                  onTap: () => setState(() {
                        this.isShowInfo = !this.isShowInfo;
                      })),
            },
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

  onMapCreated(GoogleMapController controller) {
    this.controller = controller;
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
