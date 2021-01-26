import 'package:flutter/material.dart';
import 'package:reportes/Widgets/drawer_widget.dart';

class FeedBackPage extends StatefulWidget {
  FeedBackPage({Key key}) : super(key: key);
  @override
  _StateFeedBackPage createState() => _StateFeedBackPage();
}

class _StateFeedBackPage extends State<FeedBackPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('Feedback'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Feedback'),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
