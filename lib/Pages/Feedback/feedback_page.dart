import 'package:flutter/material.dart';
import 'package:reportes/Widgets/feedback_sdk_widget.dart';
import 'package:reportes/Pages/Feedback/feedback_form.dart';

class FeedBackPage extends StatefulWidget {
  FeedBackPage({Key key}) : super(key: key);
  @override
  _StateFeedBackPage createState() => _StateFeedBackPage();
}

class _StateFeedBackPage extends State<FeedBackPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.fiber_new),
              ),
              Tab(
                icon: Icon(Icons.list_alt),
              ),
            ],
          ),
          title: Text('Contacto'),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [FeedBackForm(), FeedBackSdkWidget()],
        ),
      ),
    );
  }
}
