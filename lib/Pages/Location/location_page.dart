import 'package:flutter/material.dart';
import 'package:reportes/Widgets/drawer_widget.dart';

class LocationPage extends StatefulWidget {
  LocationPage({Key key}) : super(key: key);
  @override
  _StateLocationPage createState() => _StateLocationPage();
}

class _StateLocationPage extends State<LocationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('Location'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Location'),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
